
resource "aws_s3_bucket" "s3_findings" {
  bucket = var.bucket_name
  acl    = var.acl_access_bucket
  versioning {
    enabled = var.versioning_enabled
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.enc_algorithm
        kms_master_key_id = var.kms_key
      }
    }
  }
  tags = var.config_tags
}