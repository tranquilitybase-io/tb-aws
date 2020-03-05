locals {
  region = data.aws_region.current.name
  region_findings = data.aws_region.current.name
  bucket_name_findings = "aws-lz-s3-guardduty-findings-${local.current_account_id}-${local.region}"
}

data "aws_iam_policy_document" "guardduty_s3_policy"{      
  statement {    
    sid= "Allow GuardDuty to use the getBucketLocation operation"
    effect= "Allow"
    principals {
      type = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
    actions= ["s3:GetBucketLocation"]
    resources= ["arn:aws:s3:::${local.bucket_name_findings}"]
  }
  statement {
    sid= "Allow GuardDuty to upload objects to the bucket"
    effect= "Allow"
    principals {
      type = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
    actions= ["s3:PutObject"]
    resources= ["arn:aws:s3:::${local.bucket_name_findings}/*"]
  }
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
  source = "./modules/guardduty/guardduty-iam"
  
  providers = {
    aws = aws.logarchive-account
  }
  policy_name        = var.s3_guardduty_policy_name
  policy_description = var.s3_guardduty_policy_description
  policy = data.aws_iam_policy_document.guardduty_s3_policy.json
}