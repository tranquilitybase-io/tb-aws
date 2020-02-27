output "role_arn" {
  value = aws_iam_role.main.arn
}

output "policy_arn" {
  value = aws_iam_policy.aws_config_policy.arn
}