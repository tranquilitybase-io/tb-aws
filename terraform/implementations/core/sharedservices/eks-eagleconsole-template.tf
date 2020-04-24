# EKS cluster
module "aws_lz_eks_eagleconsole_cluster" {
  source = "./modules/eks"
  providers = {
    aws = aws.network-account
  }

  eks_cluster_name          = var.ec_eks_cluster_name
  eks_iam_role_name         = var.ec_eks_role_name
  subnets                   = module.aws_lz_ingress_vpc.private_subnets
  # eks_user_policy         = data.aws_iam_policy_document.aws_lz_eks_cluster_sharedservices.json

  node_group_name           = var.ec_eks_node_group_name
  node_group_role_name      = var.ec_eks_node_group_role_name
  node_group_subnets        = module.aws_lz_ingress_vpc.private_subnets
  node_group_instance_types = ["t3.small"]
}
# END EKS cluster
