
resource "aws_s3_bucket" "s3_main" {
  bucket = var.bucket_name
  acl    = "log-delivery-write"
  versioning {
    enabled = var.versioning_enabled
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = var.org_tags
}

resource "aws_s3_bucket" "s3_log" {
  bucket = var.bucket_name_log
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.s3_main.id
    target_prefix = var.config_logs_prefix
  }
  versioning {
    enabled = var.versioning_enabled
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = var.org_tags
}