
resource "aws_sns_topic" "sns_topic_default" {
  name              = var.sns_topic_name
  kms_master_key_id = var.kms_master_key_id  
  tags   = var.required_tags
}