resource "aws_cloudtrail" "cloudtrail_default" {
  count = length(var.cloudtrail_name) > 0 ? 1 : 0

  name                       = var.cloudtrail_name
  is_multi_region_trail      = var.multi_region_trail
  include_global_service_events = var.include_global_events
  is_organization_trail      = var.organization_trail
  s3_bucket_name             = var.bucket_name
  s3_key_prefix              = var.s3_log_prefix
  enable_logging             = var.enable_logging
  enable_log_file_validation = var.enable_log_file_validation
  sns_topic_name             = aws_sns_topic.cloudtrail.name
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group_default.arn
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_role.arn
  tags                       = var.required_tags
}

resource "aws_sns_topic_policy" "sns_default_policy" {
  count = length(var.cloudtrail_name) > 0 ? 1 : 0

  arn = var.sns_topic_arn
  policy = data.aws_iam_policy_document.cloudtrail_alarm_policy.json
}

resource "aws_cloudwatch_log_group" "log_group_default" {
  count = length(var.cloudtrail_name) > 0 ? 1 : 0

  name = "${var.cloudtrail_name}_default_log_group"
  retention_in_days = var.logs_retencion_days
  tags = var.required_tags
}

resource "aws_iam_role" "cloudtrail_role" {
  count = length(var.cloudtrail_name) > 0 ? 1 : 0

  name               = "${var.cloudtrail_name}_role"
  assume_role_policy = data.aws_iam_policy_document.cloudtrail_assume_policy.json
  tags               = var.required_tags
}

resource "aws_iam_policy" "cloudtrail_access_policy" {
  count = length(var.cloudtrail_name) > 0 ? 1 : 0

  name   = "${var.cloudtrail_name}_policy"
  policy = data.aws_iam_policy_document.cloudtrail_cloudwatch_policy.json
}

resource "aws_iam_policy_attachment" "cloudtrail_access_policy_attachment" {
  count = length(var.cloudtrail_name) > 0 ? 1 : 0

  name       = "${var.cloudtrail_name}_policy_attachment"
  policy_arn = aws_iam_policy.cloudtrail_access_policy.arn
  roles      = [aws_iam_role.cloudtrail_role.name]
}


resource "aws_sns_topic" "cloudtrail" {
  count = length(var.cloudtrail_name) > 0 ? 1 : 0

  name = "${var.cloudtrail_name}_logging_sns_topic"
}

resource "aws_sns_topic_policy" "cloudtrail_topic_policy" {
  count = length(var.cloudtrail_name) > 0 ? 1 : 0

  arn    = aws_sns_topic.cloudtrail.arn
  policy = data.aws_iam_policy_document.cloudtrail_sns.json
}