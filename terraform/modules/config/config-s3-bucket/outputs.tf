output "bucket_name" {
    value = aws_s3_bucket.s3_main.bucket
}

output "bucket_name_arn" {
    value = aws_s3_bucket.s3_main.arn
}

output "bucket_name_log" {
    value = aws_s3_bucket.s3_log.bucket
}

output "bucket_log_arn" {
    value = aws_s3_bucket.s3_log.arn
}

output "config_logs_prefix" {
    value = var.config_logs_prefix
}
