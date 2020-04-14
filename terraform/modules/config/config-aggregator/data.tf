# Allow IAM policy to assume the role for AWS Config
data "aws_iam_policy_document" "aws_aggregator_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }

    effect = "Allow"
  }
}