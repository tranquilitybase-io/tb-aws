output "key_arn" {
    value = aws_lz_finding_bucket_key.kms_key.arn
}

output "key_id" {
    value = aws_lz_finding_bucket_key.kms_key.id
}
