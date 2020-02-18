data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {  
  account_id = data.aws_caller_identity.current.account_id  
  region = data.aws_region.current.name
  bucket_name = "aws-lz-s3-access-logs-${local.account_id}-${local.region}"
  bucket_name_log = "aws-lz-s3-logs-${local.account_id}-${local.region}"  
}

resource "aws_s3_bucket" "s3_main" {
  bucket = local.bucket_name
  acl    = "log-delivery-write"
  versioning {
    enabled = true
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = var.default_tags
}

resource "aws_s3_bucket" "s3_log" {
  bucket = local.bucket_name_log
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.s3_main.id
    target_prefix = var.config_logs_prefix
  }
  versioning {
    enabled = true
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = var.default_tags
}