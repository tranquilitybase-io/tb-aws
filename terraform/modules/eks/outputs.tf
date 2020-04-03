output "unique_id" {
  value = concat(aws_iam_role.aws_lz_gft_eks_role.*.id, [""])[0]
  description = "ID of the role"
}
output "role_arn" {
  value = concat(aws_iam_role.aws_lz_gft_eks_role.*.arn, [""])[0]
  description = "Role ARN"
}
output "role_name" {
  value = concat(aws_iam_role.aws_lz_gft_eks_role.*.name, [""])[0]
  description = "Role Name"
}