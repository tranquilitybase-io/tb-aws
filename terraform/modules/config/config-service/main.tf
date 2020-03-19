#
# AWS Config Service
#

resource "aws_config_configuration_recorder" "main" {
  count = length(var.config_name) > 0 ? 1 : 0

  name     = "${var.config_name}_recorder"
  role_arn = aws_iam_role.main[count.index].arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "main" {
  count = length(var.config_name) > 0 ? 1 : 0

  name           = aws_config_configuration_recorder.main.name
  s3_bucket_name = var.config_logs_bucket
  s3_key_prefix  = var.s3_log_prefix

  sns_topic_arn = var.sns_topic_arn

  snapshot_delivery_properties {
    delivery_frequency = var.config_delivery_frequency
  }
}

resource "aws_config_configuration_recorder_status" "main" {
  count = length(var.config_name) > 0 ? 1 : 0

  name       = aws_config_delivery_channel.main.name
  is_enabled = true
}

resource "aws_iam_role" "main" {
  count = length(var.config_name) > 0 ? 1 : 0

  name               = "${var.config_name}_iam_role"
  assume_role_policy = data.aws_iam_policy_document.aws_config_role_policy.json
  tags = var.config_tags
}

resource "aws_iam_policy_attachment" "managed_policy" {
  count = length(var.config_name) > 0 ? 1 : 0

  name       = "${var.config_name}_managed_policy"
  roles      = [aws_iam_role.main[count.index].name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

resource "aws_sns_topic_policy" "sns_config_default_policy" {
  count = length(var.config_name) > 0 ? 1 : 0

  arn = var.sns_topic_arn  
  policy = data.aws_iam_policy_document.config_sns.json
}

