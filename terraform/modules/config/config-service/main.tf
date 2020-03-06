#
# AWS Config Service
#

resource "aws_config_configuration_recorder_status" "main" {
  name       = "${var.config_name}_${var.recorder_name}"
  is_enabled = true
  depends_on = [aws_config_delivery_channel.main]
}

resource "aws_config_delivery_channel" "main" {
  name           = var.aws_config_delivery_channel_name
  s3_bucket_name = var.config_logs_bucket
  s3_key_prefix  = var.s3_log_prefix

  #sns_topic_arn = aws_sns_topic.config_sns_topic.arn
  sns_topic_arn = var.sns_topic_arn

  snapshot_delivery_properties {
    delivery_frequency = var.config_delivery_frequency
  }
  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_configuration_recorder" "main" {
  name     = "${var.config_name}_${var.recorder_name}"
  #role_arn = var.role_arn
  role_arn = "arn:aws:iam::${var.topic_account_id}:role/${var.org_admin_role}"

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

/* resource "aws_sns_topic" "config_sns_topic" {
  name              = "${var.config_name}_sns_topic"
  kms_master_key_id = var.kms_master_key_id
  tags = var.config_tags
} */

/* resource "aws_sns_topic_policy" "sns_default_policy" {
  arn = var.sns_topic_arn  
  policy = data.aws_iam_policy_document.sns_topic_policy.json
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
      "SNS:Receive",
    ]
    
    resources = ["${var.sns_topic_arn}"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values   = ["${var.topic_account_id}"]
    }
  }
} */
