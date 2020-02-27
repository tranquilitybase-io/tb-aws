#
# AWS Config Service
#

resource "aws_config_configuration_recorder_status" "main" {
  name       = "${var.config_name}_${var.recorder_name}"
  is_enabled = true
  depends_on = [aws_config_delivery_channel.main]
}

resource "aws_config_configuration_recorder" "main" {
  name     = "${var.config_name}_${var.recorder_name}"
  role_arn = var.role_arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "main" {
  name           = var.aws_config_delivery_channel_name
  s3_bucket_name = var.config_logs_bucket
  s3_key_prefix  = var.s3_log_prefix

  sns_topic_arn = var.sns_topic_arn

  snapshot_delivery_properties {
    delivery_frequency = var.config_delivery_frequency
  }
  depends_on = [aws_config_configuration_recorder.main]
}

