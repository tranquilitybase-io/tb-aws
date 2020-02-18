
resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
  prefix = var.config_logs_prefix
  acl    = "private"
  tags = var.default_tags
}