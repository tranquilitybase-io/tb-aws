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