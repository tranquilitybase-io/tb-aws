locals {
  region = data.aws_region.current.name
  region_findings = data.aws_region.current.name
  bucket_name_findings = "aws-lz-s3-guardduty-findings-${local.current_account_id}-${local.region}"
}

data "template_file" "guardduty_s3_policy"{
  template = <<JSON
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Allow GuardDuty to use the getBucketLocation operation",
            "Effect": "Allow",
            "Principal": {
                "Service": "guardduty.amazonaws.com"
            },
            "Action": "s3:GetBucketLocation",
            "Resource": "arn:aws:s3:::${local.bucket_name_findings}"
        },
        {
            "Sid": "Allow GuardDuty to upload objects to the bucket",
            "Effect": "Allow",
            "Principal": {
                "Service": "guardduty.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${local.bucket_name_findings}/*"
        },
        {
            "Sid": "Deny unencrypted object uploads. This is optional",
            "Effect": "Deny",
            "Principal": {
                "Service": "guardduty.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${local.bucket_name_findings}/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "aws:kms"
                }
            }
        }
    ]
  }
}
JSON

module "aws_lz_finding_bucket_key" {
  source = "./modules/kms"
  
  providers = {
    aws = aws.logarchive-account
  }
  key_description = var.description
  kms_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.current_account_id, (var.tag_key_name) = "config" }
}

module "aws_lz_guardduty_bucket" {
  source = "./modules/guardduty/guardduty-iam"
  
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
  name        = var.s3_guardduty_policy_name
  description = var.s3_guardduty_policy_description
  policy = data.template_file.guardduty_s3_policy.rendered  
}