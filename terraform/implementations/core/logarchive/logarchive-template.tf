module "aws_lz_config_bucket" {
  source = "./modules/config/config-s3-bucket"

  bucket_name = local.bucket_name

  bucket_name_log = local.bucket_name_log
  s3_log_prefix = var.s3_log_prefix

  config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.logarchive_account_id, (var.tag_key_name) = "config" }

  providers = {
    aws = aws.logarchive-account
  }
}

module "aws_lz_finding_bucket_key" {
  source = "./modules/kms"
  
  providers = {
    aws = aws.logarchive-account
  }
  key_description = var._description
  kms_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.current_account_id, (var.tag_key_name) = "config" }
}


module "aws_lz_guardduty_bucket" {
  source = "./modules/s3/"
  
  providers = {
    aws = aws.logarchive-account
  }
  kms_key = module.aws_lz_finding_bucket_key.key_id
  bucket_name = local.bucket_name_findings
  config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.current_account_id, (var.tag_key_name) = "config" }
}


module "guardduty_s3_policy" {
  source = "./modules/guardduty/bucket_policy"
  
  providers = {
    aws = aws.logarchive-account
  }
  bucket_arn = module.aws_lz_guardduty_bucket.bucket_name_arn
  bucket_name = local.bucket_name_findings
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Guardduty_bucket_policy",
    "Statement": [
      {
          "Sid": "GuardDutyAllow",
          "Effect": "Allow",
          "Principal": {
              "Service": "guardduty.amazonaws.com"
          },
          "Action": "s3:GetBucketLocation",
          "Resource": "arn:aws:s3:::${local.bucket_name_findings}"
      }
    ]
  }
  POLICY
}

 #SECURITY ROLES
 module "aws_lz_iam_security_admin_logarchive" {
   source = "./modules/iam"
 
   providers = {
     aws = aws.logarchive-account
   }

   role_name = "${local.security_role_name}"
   assume_role_policy = "${data.aws_iam_policy_document.aws_lz_assume_role_security.json}"
   role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.logarchive_account_id }

   #attachment
  role_policy_attach = true
  policy_arn = local.administrator_access_arn
 }

  module "aws_lz_iam_security_audit_logarchive" {
   source = "./modules/iam"
   providers = {
     aws = aws.logarchive-account
   }

   role_name = "${local.security_role_name_audit}"
   assume_role_policy = "${data.aws_iam_policy_document.aws_lz_assume_role_security.json}"
   role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.logarchive_account_id }
   #attachment
   role_policy_attach = true
   policy_arn = local.read_only_access_arn
  }