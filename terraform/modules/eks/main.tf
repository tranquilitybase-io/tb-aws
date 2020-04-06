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