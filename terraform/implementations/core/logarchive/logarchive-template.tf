locals {
  log_archive_account_id = module.aws_lz_account_logarchive.account_id
  bucket_name = "aws-lz-s3-access-logs-${local.log_archive_account_id}-${local.region}"
  bucket_name_log = "aws-lz-s3-logs-${local.log_archive_account_id}-${local.region}"  
}

data "template_file" "logarchive_bucket_policy" {
  template = <<JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "AWSConfigBucketPermissionsCheck",
        "Effect": "Allow",
        "Principal" : {
          "Service" : [
            "cloudtrail.amazonaws.com",
            "config.amazonaws.com"
          ]
        },
        "Action": "s3:GetBucketAcl",
        "Resource": "${module.aws_lz_config_bucket.bucket_log_arn}"
    },
    {
        "Sid": "AWSConfigBucketDelivery",
        "Effect": "Allow",
        "Principal" : {
          "Service" : [
            "cloudtrail.amazonaws.com",
            "config.amazonaws.com"
          ]
        },
        "Action": "s3:PutObject",
        "Resource": ["$${config_resource}","$${cloudtrail_resource}"],
        "Condition": {
          "StringLike": {
            "s3:x-amz-acl": "bucket-owner-full-control"
          }
        }
    }
  ]
}
JSON

  vars = { 
    config_resource = format("%s/%s/AWSLogs/%s/Config/*",module.aws_lz_config_bucket.bucket_log_arn,module.aws_lz_config_bucket.s3_log_prefix,local.log_archive_account_id)
    cloudtrail_resource = format("%s/%s/AWSLogs/%s/CloudTrail/*",module.aws_lz_config_bucket.bucket_log_arn,module.aws_lz_config_bucket.s3_log_prefix,local.log_archive_account_id)
  }
}

module "aws_lz_config_bucket" {
  source = "./modules/config/config-s3-bucket"
   
  bucket_name = local.bucket_name
  config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.log_archive_account_id, (var.tag_key_name) = "config" }
  bucket_name_log = local.bucket_name_log
  s3_log_prefix = var.s3_log_prefix 
  providers = {
    aws = aws.logarchive-account
  }
}

/*
module "aws_s3_bucket_policy_logarchive"{
    source = "./modules/s3"
    
    bucket_name = module.aws_lz_config_bucket.bucket_name_log
    s3_bucket_policy = data.template_file.logarchive_bucket_policy.rendered

    providers = {
      aws = aws.logarchive-account
    }
}*/



