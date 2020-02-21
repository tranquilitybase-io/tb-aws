
variable "config_logs_bucket" {    
    default = ""
}

variable "config_name" {  
    default = ""
}

variable "config_tags" {
  default = {} 
}

variable "config_logs_prefix" { 
    default = ""
}

variable "role_arn" {
  description = "The ARN of role."
}

variable "sns_topic_name" {
  description = "Topic Name"
  default = "$${config_name}-sns-topic"
}

variable "kms_master_key_id" {
  description = "KMS by default for SNS topic"
  default = "alias/aws/sns"
}

variable "aws_config_delivery_channel_name" {
  description = "Name of Delivery Channel"
  default = "$${config_name}-delivery"
}

variable "config_delivery_frequency" {
  description = "The frequency with which AWS Config delivers configuration snapshots."
  default     = "Six_Hours"
}
