output "bucket_name" {
    value = aws_s3_bucket.s3_findings.bucket
}

output "bucket_name_arn" {
    value = aws_s3_bucket.s3_findings.arn
}
