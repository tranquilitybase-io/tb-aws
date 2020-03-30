/*
* # GFT AWS LZ S3 Bucket Terraform module
*
* Usage: Module to create a S3 bucket to store logs files from Config and CloudTrail, the bucket is encrypted at rest using "AES256" as algorithm. The module create 2 buckets one for access and another with logging activated.
*/

resource "aws_s3_bucket" "s3_main" {
  bucket = var.bucket_name
  acl    = var.acl_access_bucket
  versioning {
    enabled = var.versioning_enabled
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.sse_aes256
      }
    }
  }
  tags = var.config_tags
}

resource "aws_s3_bucket" "s3_log" {
  bucket = var.bucket_name_log
  acl    = var.acl_logs_bucket

  logging {
    target_bucket = aws_s3_bucket.s3_main.id
    target_prefix = var.s3_log_prefix
  }
  versioning {
    enabled = var.versioning_enabled
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.sse_aes256
      }
    }
  }
  tags = var.config_tags
}

resource "aws_s3_bucket_policy" "aws_lz_s3_bucket_policy" {
  count   = length(var.bucket_name_log) > 0 ? 1 : 0

  bucket   = aws_s3_bucket.s3_log.id
  policy = data.template_file.logarchive_bucket_policy.rendered
}