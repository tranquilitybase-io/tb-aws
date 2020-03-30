output "bucket_name" {
    value = aws_s3_bucket.s3_main.bucket
    description = "Bucket Name"
}

output "bucket_name_arn" {
    value = aws_s3_bucket.s3_main.arn
    description = "Bucket ARN"
}

output "bucket_name_log" {
    value = aws_s3_bucket.s3_log.bucket
    description = "Logging Bucket Name"
}

output "bucket_log_arn" {
    value = aws_s3_bucket.s3_log.arn
    description = "Logging Bucket ARN"
}

output "s3_log_prefix" {
    value = var.s3_log_prefix
    description = "S3 Log Prefix"
}
