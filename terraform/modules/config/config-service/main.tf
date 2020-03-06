
# Allow IAM policy to assume the role for AWS Config
data "aws_iam_policy_document" "aws_config_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com","cloudtrail.amazonaws.com",]
    }

    effect = "Allow"
  }
}

#
# IAM
#
resource "aws_iam_role" "main" {
  name               = "${var.config_name}_iam_role"
  assume_role_policy = data.aws_iam_policy_document.aws_config_role_policy.json
  tags = var.config_tags
}

resource "aws_iam_policy_attachment" "managed_policy" {
  name       = "${var.config_name}_managed_policy"
  roles      = [aws_iam_role.main.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

#
# AWS Config Service
#
resource "aws_config_configuration_recorder_status" "main" {
  name       = "${var.config_name}_recorder"
  is_enabled = true
  #depends_on = [aws_config_delivery_channel.main]
}

resource "aws_config_delivery_channel" "main" {
  name           = "${var.config_name}_delivery_channel"
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
  name     = "${var.config_name}_recorder"
  role_arn = aws_iam_role.main.arn
  #role_arn = "arn:aws:iam::${var.topic_account_id}:role/${var.org_admin_role}"

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

/* resource "aws_sns_topic_policy" "sns_default_policy" {
  arn = var.sns_topic_arn  
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}*/

/*data "aws_iam_policy_document" "sns_topic_policy" {
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
}*/
