locals {
  region = data.aws_region.current.name
  region_findings = data.aws_region.current.name
  bucket_name_findings = "aws-lz-s3-guardduty-findings-${local.current_account_id}-${local.region}"
}

module "aws_lz_finding_bucket_key" {
  source = "./modules/kms"
  
  providers = {
    aws = aws.logarchive-account
  }
  key_description = var.description
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