
# Allow IAM policy to assume the role for AWS Config
data "aws_iam_policy_document" "aws_config_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "config_sns" {
  statement {
    actions = [
      "sns:Publish",
    ]
    principals {
      identifiers = [
        "config.amazonaws.com",
      ]
      type = "Service"
    }
    resources = [
      var.sns_topic_arn,
    ]
    sid = "CloudTrail SNS Policy"
  }
}