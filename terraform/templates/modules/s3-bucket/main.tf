# Get the access to the effective Account ID in which Terraform is working.
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
  acl    = "private"
  force_destroy = true

  tags = {
    Name        = "LZ Config Bucket"
    Environment = "DEV"
    AccountID   = data.aws_caller_identity.current.account_id
  }  
}