
resource "aws_s3_bucket" "s3_findings" {
  bucket = "testing-s3-findings1122332020" #var.bucket_name
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

resource "aws_s3_bucket_policy" "aws_lz_s3_bucket_policy" {
    count   = length(var.bucket_name) > 0 ? 1 : 0
    
    bucket   = var.bucket_name
    policy = var.s3_bucket_policy
}