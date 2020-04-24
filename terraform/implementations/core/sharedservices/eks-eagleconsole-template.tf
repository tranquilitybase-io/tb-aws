# EKS cluster
module "aws_lz_eks_eagleconsole_cluster" {
  source = "./modules/eks"
  providers = {
    aws = aws.sharedservices-account
  }

  eks_cluster_name          = var.ec_eks_cluster_name
  eks_iam_role_name         = var.ec_eks_role_name
  subnets                   = module.vpc_shared_services.private_subnets
  # eks_user_policy         = data.aws_iam_policy_document.aws_lz_eks_cluster_sharedservices.json

  node_group_name           = var.ec_eks_node_group_name
  node_group_role_name      = var.ec_eks_node_group_role_name
  node_group_subnets        = module.vpc_shared_services.private_subnets
  node_group_instance_types = ec_eks_node_group_instance_types
}
# END EKS cluster
