
resource "aws_kms_key" "s3_guardduty_key" {
  description = var.key_description
  tags = var.config_tags
}