
resource "aws_kms_key" "kms_key" {
  description = var.key_description
  tags = var.kms_tags
}

resource "aws_kms_grant" "guardduty_key_permission" {
  name = var.key_permission_name
  key_id = "${aws_kms_key.kms_key.key_id}"
  grantee_principal = var.key_permission_principal
  operations = var.key_permission_operations
}