resource "aws_cloudtrail" "cloudtrail_default" {
  name                       = var.cloudtrail_name
  is_multi_region_trail      = var.multi_region_trail
  is_organization_trail      = var.organization_trail
  s3_bucket_name             = var.bucket_name
  s3_key_prefix              = var.s3_log_prefix
  enable_logging             = var.enable_logging
  enable_log_file_validation = var.enable_log_file_validation
  #cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group_default.arn
  #cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_role.arn
  include_global_service_events = var.include_global_events
  sns_topic_name                = module.aws_lz_cloudtrail_sns_topic.topic_arn
  tags                       = var.required_tags
}

/*resource "aws_cloudwatch_log_group" "log_group_default" {
  name = "${var.cloudtrail_name}_cloudwatch_log_group"
  retention_in_days = var.logs_retencion_days
  tags = var.required_tags
}*/

/*resource "aws_iam_role" "cloudtrail_role" {
  name               = "${var.cloudtrail_name}_role"
  assume_role_policy = data.aws_iam_policy_document.cloudtrail_assume_policy.json
  tags               = var.required_tags
}

resource "aws_iam_policy" "cloudtrail_access_policy" {
  name   = "${var.cloudtrail_name}_cloudwatch_policy"
  policy = data.aws_iam_policy_document.cloudtrail_policy.json
}*/

/*
resource "aws_sns_topic_policy" "sns_default_policy" {
  arn = var.sns_topic_arn
  policy = data.aws_iam_policy_document.cloudtrail_alarm_policy.json
}
*/

