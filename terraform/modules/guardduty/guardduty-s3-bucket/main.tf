
resource "aws_s3_bucket" "s3_findings" {
  bucket = var.findings_bucket_name
  acl    = var.findings_acl_access_bucket
  versioning {
    enabled = var.findings_versioning_enabled
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.findings_sse_aes256
      }
    }
  }
  tags = var.findings_config_tags
}