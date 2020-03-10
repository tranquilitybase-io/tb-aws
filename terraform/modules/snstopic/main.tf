
resource "aws_sns_topic" "sns_topic_default" {
  count = length(var.sns_topic_name) > 0 ? 1 : 0
  
  name              = var.sns_topic_name
  kms_master_key_id = var.kms_master_key_id
  tags   = var.required_tags
}