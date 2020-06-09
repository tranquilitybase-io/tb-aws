output "role_arn" {
  value = concat(aws_iam_role.aws_lz_gft_eks_iam_role.*.arn, [""])[0]
  description = "Role ARN"
}


output "cluster_ca" {
  description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
  value       = concat(aws_eks_cluster.aws_lz_eks_cluster.*.certificate_authority.0.data, [""])[0]
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes."
  value       = concat(aws_eks_cluster.aws_lz_eks_cluster.*.endpoint, [""])[0]
}

output "cluster_id" {
  description = "ID for your EKS Kubernetes."
  value       = concat(aws_eks_cluster.aws_lz_eks_cluster.*.id, [""])[0]
}
