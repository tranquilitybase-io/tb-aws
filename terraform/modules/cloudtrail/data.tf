
data "aws_iam_policy_document" "cloudtrail_assume_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "cloudtrail_cloudwatch_policy" {
  statement {
    sid = "AWSCloudTrailLogging"
    effect    = "Allow"
    actions   = ["logs:CreateLogStream","logs:PutLogEvents"]
    resources = ["arn:aws:logs:${var.region}:${var.bucket_account_id}:log-group:*:log-stream:*"]
  }
}

data "aws_iam_policy_document" "cloudtrail_alarm_policy" {
  statement {
    sid = "AWSLZCloudTrailSNSPolicy"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = ["SNS:GetTopicAttributes",
               "SNS:SetTopicAttributes",
               "SNS:AddPermission",
               "SNS:RemovePermission",
               "SNS:DeleteTopic",
               "SNS:Subscribe",
               "SNS:ListSubscriptionsByTopic",
               "SNS:Publish",
               "SNS:Receive",
              ]
    resources = [var.sns_alarm_topic_arn]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values   = ["${var.bucket_account_id}"]
    }
  }
}

data "aws_iam_policy_document" "cloudtrail_sns" {
  statement {
    actions = [
      "sns:Publish",
    ]
    principals {
      identifiers = [
        "cloudtrail.amazonaws.com",
      ]
      type = "Service"
    }
    resources = [
      aws_sns_topic.cloudtrail.arn,
    ]
    sid = "CloudTrail SNS Policy"
  }
}