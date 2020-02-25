output "bucket_name" {
    value = aws_s3_bucket.s3_main.bucket
}

output "bucket_name_log" {
    value = aws_s3_bucket.s3_log.bucket
}

output "config_logs_prefix" {
    value = var.config_logs_prefix
}
