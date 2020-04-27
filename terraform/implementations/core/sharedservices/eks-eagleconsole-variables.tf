# EKS Cluster
variable "ec_eks_cluster_name" {
  description = "Shared Services EKS cluster name"
  default     = "awslz_eks_eagleconsole"
}

variable "ec_eks_role_name" {
  description = "EKS role name"
  default     = "awslz_eks_eagleconsole_cluster_role"
}

variable "ec_eks_node_group_name" {
  description = "Cluster node group name"
  default     = "awslz_eks_eagleconsole_node_group"
}

variable "ec_eks_node_group_role_name" {
  description = "Cluster node group name role_role"
  default     = "awslz_eks_eagleconsole_node_group"
}

variable "ec_eks_node_group_instance_types" {
  description = "Instances types for the node group"
  default     = ["t3.small"]
}