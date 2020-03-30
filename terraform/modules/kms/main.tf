/*
* # GFT AWS LZ KMS Service Terraform module
*
* Usage: Terraform module which generates KMS key to be used as encryption algorithm in a S3 bucket.
*/

resource "aws_kms_key" "kms_key" {
  description = var.key_description
  tags = var.kms_tags
}