resource "aws_iam_role" "aws_lz_gft_eks_iam_role" {
  name = var.eks_iam_role_name #"eks-cluster-ingress-role"

  assume_role_policy = var.eks_user_policy
}

resource "aws_iam_role_policy_attachment" "aws_lz_gft_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.aws_lz_gft_eks_iam_role.name
}

resource "aws_iam_role_policy_attachment" "aws_lz_gft_AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.aws_lz_gft_eks_iam_role.name
}

resource "aws_eks_cluster" "eks_ingress_cluster" {
  name     = var.eks_cluster_name #"eks_ingress_cluster"
  role_arn = aws_iam_role.aws_lz_gft_eks_iam_role.arn

  vpc_config {
    #subnet_ids = ["${aws_subnet.example1.id}", "${aws_subnet.example2.id}"]
    subnet_ids = var.subnets
  }

  depends_on = [
    aws_iam_role_policy_attachment.aws_lz_gft_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.aws_lz_gft_AmazonEKSServicePolicy,
  ]
}

###### Node Group

#resource "aws_eks_node_group" "example" {
  #cluster_name    = var.eks_cluster_name
  #node_group_name = var.nodes_group_name
  #node_role_arn   = aws_iam_role.example.arn
  #subnet_ids      = aws_subnet.example[*].id
#
  #scaling_config {
    #desired_size = 1
    #max_size     = 1
    #min_size     = 1
  #}
#
  ## Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  ## Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  #depends_on = [
    #aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    #aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    #aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  #]
#}

###### IAM Role for EKS Node Group

resource "aws_iam_role" "aws_lz_gft_rkd_node_role" {
  name = "aws_lz_gft_eks_node_group"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}