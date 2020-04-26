/*
* # GFT AWS LZ EKS Terraform module
*
* Usage: Terraform module which creates EKS cluster and node groups with the required configuration.
*
*/

resource "aws_iam_role" "aws_lz_gft_eks_iam_role" {
  name = var.eks_iam_role_name
  assume_role_policy = var.eks_user_policy
}

resource "aws_iam_role_policy_attachment" "awslz_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.aws_lz_gft_eks_iam_role.name
}

resource "aws_iam_role_policy_attachment" "awslz_AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.aws_lz_gft_eks_iam_role.name
}

resource "aws_eks_cluster" "aws_lz_eks_cluster" {
  count = length(var.eks_cluster_name) > 0 ? 1 : 0

  name     = var.eks_cluster_name
  role_arn = aws_iam_role.aws_lz_gft_eks_iam_role.arn

  vpc_config {
    subnet_ids = var.subnets
  }

  cluster_endpoint_private_access = true
  
  depends_on = [
    aws_iam_role_policy_attachment.awslz_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.awslz_AmazonEKSServicePolicy,
  ]
}

###### Node Group
resource "aws_eks_node_group" "awslz_eks_node_group" {
  count = length(var.node_group_name) > 0 ? 1 : 0

  cluster_name      = var.eks_cluster_name
  node_group_name   = var.node_group_name
  node_role_arn     = aws_iam_role.awslz_eks_node_group_role.arn
  subnet_ids        = var.node_group_subnets
  instance_types    = var.node_group_instance_types

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_eks_cluster.aws_lz_eks_cluster,
    aws_iam_role_policy_attachment.awslz_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.awslz_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.awslz_AmazonEC2ContainerRegistryReadOnly,
  ]
}

###### IAM Role for EKS Node Group
resource "aws_iam_role" "awslz_eks_node_group_role" {
  name = var.node_group_role_name
  assume_role_policy = var.node_group_role_policy 
}

resource "aws_iam_role_policy_attachment" "awslz_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.awslz_eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "awslz_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.awslz_eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "awslz_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.awslz_eks_node_group_role.name
}