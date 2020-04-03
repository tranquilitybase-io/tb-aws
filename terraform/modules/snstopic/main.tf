/*
* # GFT AWS LZ SNS Topic Terraform module
*
* Usage: Terraform module which creates SNS Topic.
*/

resource "aws_sns_topic" "sns_topic_default" {
  count = length(var.sns_topic_name) > 0 ? 1 : 0

  name              = var.sns_topic_name
  kms_master_key_id = var.kms_master_key_id
  tags   = var.required_tags
}

resource "aws_sns_topic_policy" "default_access_policy" {
  count = var.attach_policy == true 1 : 0
  arn = aws_sns_topic.sns_topic_default[count.index].arn
  policy = var.policy
}