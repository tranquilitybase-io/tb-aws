
resource "aws_kms_key" "lz_config_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "s3_main" {
  bucket = var.bucket_name
  acl    = "log-delivery-write"
  versioning {
    enabled = true
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.lz_config_key.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
  tags = var.default_tags
}

resource "aws_s3_bucket" "s3_log" {
  bucket = var.bucket_name_log
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
        kms_master_key_id = "${aws_kms_key.lz_config_key.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
  tags = var.default_tags
}