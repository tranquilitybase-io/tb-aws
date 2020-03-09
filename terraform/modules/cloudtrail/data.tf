

locals {
  resource = format("%s/%s/AWSLogs/*/CloudTrail/*",var.bucket_arn,var.s3_log_prefix)
}

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

data "aws_iam_policy_document" "cloudtrail_policy" {
  statement {
    effect    = "Allow"
    actions   = ["logs:CreateLogStream"]
    resources = ["arn:aws:logs:${var.region}:${var.bucket_account_id}:log-group:*:log-stream:*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["logs:PutLogEvents"]
    resources = ["arn:aws:logs:${var.region}:${var.bucket_account_id}:log-group:*:log-stream:*"]
  }
}

data "aws_iam_policy_document" "cloudtrail_alarm_policy" {
  statement {

    effect = "Allow"

    Principals {
      Service = "cloudtrail.amazonaws.com"
    }

    actions = [
      "SNS:Publish",
    ]
    
    resources = ["${var.sns_topic_arn}"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values   = ["${var.bucket_account_id}"]
    }
  }
}