#Data source declarations
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {state = "available"}

data "aws_iam_policy_document" "aws_lz_assume_role_security" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.security_account_id}:root"]
    }

    effect = "Allow"
  }
}

data "external" "heptio_authenticator_aws_sharedservices" {
  program = ["bash", "../automation/cicd/authenticator.sh"]

  query {
    cluster_name = "var.ec_eks_cluster_name"
  }
}

data "external" "heptio_authenticator_aws_network" {
  program = ["bash", "../automation/cicd/authenticator.sh"]

  query {
    cluster_name = "var.ingress_eks_cluster_name"
  }
}