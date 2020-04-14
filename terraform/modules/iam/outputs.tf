output "unique_id" {
  value = concat(aws_iam_role.aws_lz_iam_role.*.id, [""])[0]
  description = "ID of the role"
}
output "role_arn" {
  value = concat(aws_iam_role.aws_lz_iam_role.*.arn, [""])[0]
  description = "Role ARN"
}
output "role_name" {
  value = concat(aws_iam_role.aws_lz_iam_role.*.name, [""])[0]
  description = "Role Name"
}
output "max_session_duration" {
  value = concat(aws_iam_role.aws_lz_iam_role.*.max_session_duration, [""])[0]
  description = "Max Session Duration"
}
output "force_detach_policies" {
  value = concat(aws_iam_role.aws_lz_iam_role.*.force_detach_policies, [""])[0]
  description = "Force detach policies"
}
output "create_date" {
  value = concat(aws_iam_role.aws_lz_iam_role.*.create_date, [""])[0]
  description = "Create Date"
}
output "path" {
  value = concat(aws_iam_role.aws_lz_iam_role.*.create_date, [""])[0]
  description = "Role path"
}
output "policy_arn" {
  value = concat(aws_iam_policy.aws_lz_iam_policy.*.arn, [""])[0]
  description = "Policy ARN"
}
output "policy_id" {
  value = concat(aws_iam_policy.aws_lz_iam_policy.*.id, [""])[0]
  description = "Policy ID"
}