/*
* # GFT AWS LZ EKS Service Terraform module
*
* Usage: Terraform module which creates k8s resources using AWS EKS.
*   - Each cluster will have a user with its attached policies
*/

# IAM Role for EKS Node Group
#resource "aws_iam_role" "aws_lz_gft_eks_role" {
  #name = "eks-node-group-eks_role"
#
  #assume_role_policy = jsonencode({
    #Statement = [{
      #Action = "sts:AssumeRole"
      #Effect = "Allow"
      #Principal = {
        #Service = "ec2.amazonaws.com"
      #}
    #}]
    #Version = "2012-10-17"
  #})
#}

resource "aws_iam_role_policy_attachment" "aws_lz_gft_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_role.name
}

resource "aws_iam_role_policy_attachment" "aws_lz_gft_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_role.name
}

resource "aws_iam_role_policy_attachment" "aws_lz_gft_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_role.name
}
# End IAM Role for EKS Node Group

# EKS Cluster
resource "aws_iam_role" "aws_lz_gft_eks_role" {
  count = length(var.eks_role_name) > 0 ? 1 : 0

  name = var.eks_role_name
  assume_role_policy = var.eks_user_policy
}

resource "aws_eks_cluster" "aws_lz_gft_k8s_cluster" {
  count = length(var.eks_name) > 0 ? 1 : 0
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.aws_lz_gft_eks_role[count.index].arn

  vpc_config {
    subnet_ids = module.aws_lz_ingress_vpc.public_subnets #var.eks_vpc_subnet_list
  }

  depends_on = [
    "aws_iam_role_policy_attachment.aws_lz_gft_AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.aws_lz_gft_AmazonEKSServicePolicy",
  ]
}

resource "aws_iam_role_policy_attachment" "aws_lz_gft_AmazonEKSClusterPolicy" {
  count = length(var.eks_role_name) > 0 ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.aws_lz_gft_eks_role[count.index].arn
}

resource "aws_iam_role_policy_attachment" "aws_lz_gft_AmazonEKSServicePolicy" {
  count = length(var.eks_role_name) > 0 ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.aws_lz_gft_eks_role[count.index].arn
}
# END EKS Cluster

# EKS Node Group
resource "aws_eks_node_group" "aws_lz_gft_EKS_node_group" {
  cluster_name    = var.eks_cluster_name
  node_group_name = var.eks_node_group
  node_role_arn   = aws_iam_role.aws_lz_gft_eks_role.arn
  subnet_ids      = module.aws_lz_ingress_vpc.public_subnets #aws_subnet.example[*].id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.aws_lz_gft_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.aws_lz_gft_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.aws_lz_gft_AmazonEC2ContainerRegistryReadOnly,
  ]
}
# END EKS Node Group