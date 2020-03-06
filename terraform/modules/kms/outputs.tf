output "key_arn" {
    value = aws_kms_key.kms_key.arn
}

output "key_id" {
    value = aws_kms_key.kms_key.id
}
