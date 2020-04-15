#output "unique_id" {
#  value = concat(aws_iam_role.aws_lz_gft_eks_role.*.id, [""])[0]
#  description = "ID of the role"
#}

output "role_arn" {
  value = concat(aws_iam_role.aws_lz_gft_eks_iam_role.*.arn, [""])[0]
  description = "Role ARN"
}

output "cluster_ca" {
  description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
  value       = element(concat(aws_eks_cluster.aws_lz_eks_cluster.*.certificate_authority[0].data, list("")), 0)
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = element(concat(aws_eks_cluster.aws_lz_eks_cluster.*.endpoint, list("")), 0)
}


#output "role_name" {
#  value = concat(aws_iam_role.aws_lz_gft_eks_role.*.name, [""])[0]
#  description = "Role Name"
#}aws_lz_eks_cluster