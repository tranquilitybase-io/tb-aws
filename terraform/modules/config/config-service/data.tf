
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

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive"
    ]
    
    resources = ["${var.sns_topic_arn}"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values   = ["${var.topic_account_id}"]
    }
  }
}