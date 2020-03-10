
resource "aws_sns_topic" "sns_topic_default" {
  count = length(var.sns_topic_name) > 0 ? 1 : 0

  name              = var.sns_topic_name
  #kms_master_key_id = var.kms_master_key_id
  policy = data.aws_iam_policy_document.sns_topic_policy.json
  tags   = var.required_tags
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.sns_topic_default.arn

  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

