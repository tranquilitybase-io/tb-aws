/*
* # GFT AWS LZ EKS Service Terraform module
*
* Usage: Terraform module which creates k8s resources using AWS EKS.
*   - Each cluster will have a user with its attached policies
*/

resource "aws_iam_role" "aws_lz_gft_eks_role" {
  count = length(var.eks_role_name) > 0 ? 1 : 0

  name = var.eks_role_name
  assume_role_policy = var.eks_user_policy
}

resource "aws_eks_cluster" "aws_lz_gft_k8s_cluster" {
  count = length(var.eks_name) > 0 ? 1 : 0
  name     = var.eks_name
  role_arn = aws_iam_role.aws_lz_gft_eks_role[count.index].arn

  vpc_config {
    subnet_ids = var.eks_vpc_subnet_list
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



