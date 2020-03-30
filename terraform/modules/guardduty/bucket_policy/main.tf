/*
* # GFT AWS LZ GuardDuty Service Terraform module
*
* Usage: Terraform module which activates GuardDuty Service, and attach the bucket policy for each SandBox Account.
*/

resource "aws_s3_bucket_policy" "guardduty_bucket_policy" {
  bucket = var.bucket_name
  policy = var.policy
  depends_on = [var.bucket_arn]
}