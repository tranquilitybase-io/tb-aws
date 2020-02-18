#
# AWS Config Service
#

resource "aws_config_configuration_recorder_status" "main" {
  name       = "${var.config_name}-recorder"
  is_enabled = true
  depends_on = [aws_config_delivery_channel.main]
}

resource "aws_sns_topic" "config-rules" {
  name              = "${var.config_name}-rules-sns-topic"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_config_delivery_channel" "main" {
  name           = "${var.config_name}-delivery"
  s3_bucket_name = var.config_logs_bucket
  s3_key_prefix  = var.config_logs_prefix

  sns_topic_arn = aws_sns_topic.config-rules.arn

  snapshot_delivery_properties {
    delivery_frequency = var.config_delivery_frequency
  }
  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_configuration_recorder" "main" {
  name     = var.config_name
  role_arn = var.role_arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

