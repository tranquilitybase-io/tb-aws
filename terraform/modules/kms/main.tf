
resource "aws_kms_key" "kms_key" {
  description = var.key_description
  tags = var.kms_tags
}