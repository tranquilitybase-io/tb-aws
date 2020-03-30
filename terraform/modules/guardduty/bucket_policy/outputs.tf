
output "guardduty_bucket_policy_id" {
  value = aws_s3_bucket_policy.guardduty_bucket_policy.id
  description = "Bucket Policy ID"
}