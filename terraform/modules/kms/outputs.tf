output "key_arn" {
    value = aws_kms_key.kms_key.arn
    description = "KMS key ARN"
}

output "key_id" {
    value = aws_kms_key.kms_key.id
    description = "KMS key ID"
}
