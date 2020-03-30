output "bucket_name" {
    value = aws_s3_bucket.s3_findings.bucket
    description = "Bucket Name"
}

output "bucket_name_arn" {
    value = aws_s3_bucket.s3_findings.arn
    description = "Bucket ARN"
}
