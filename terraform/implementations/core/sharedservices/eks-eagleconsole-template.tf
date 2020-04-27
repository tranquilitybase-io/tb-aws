# EKS cluster
/*
module "aws_lz_eks_eagleconsole_cluster" {
  source = "./modules/eks"
  providers = {
    aws = aws.sharedservices-account
  }

  eks_cluster_name          = var.ec_eks_cluster_name
  eks_iam_role_name         = var.ec_eks_role_name
  subnets                   = module.vpc_shared_services.private_subnets

  node_group_name           = var.ec_eks_node_group_name
  node_group_role_name      = var.ec_eks_node_group_role_name
  node_group_subnets        = module.vpc_shared_services.private_subnets
  node_group_instance_types = var.ec_eks_node_group_instance_types
}
# END EKS cluster
*/

resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  cluster_name = "ec-eks-${random_string.suffix.result}"
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "aws_eks_sg" {
  source      = "./modules/eks-2"

  providers = {
    aws = aws.sharedservices-account
  }

  eks_vpc_id = module.vpc.vpc_id
}

module "vpc" {
  providers = {
    aws = aws.sharedservices-account
  }

  source  = "terraform-aws-modules/vpc/aws"
  version = "2.6.0"

  name                 = "test-vpc"
  cidr                 = "10.99.16.0/22"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.99.16.0/24", "10.99.17.0/24"]
  public_subnets       = ["10.99.18.0/24", "10.99.19.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

module "eks" {
  providers = {
    aws = aws.sharedservices-account
  }

  source        = "terraform-aws-modules/eks/aws"
  version       = "11.1.0"
  cluster_name  = local.cluster_name
  subnets       = module.vpc.private_subnets

  tags = {
    Environment = "test"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = 1
    },
  ]

  //worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  //map_roles                            = var.map_roles
  //map_users                            = var.map_users
  //map_accounts                         = var.map_accounts
}