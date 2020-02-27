
variable "sns_topic_name" {  
}

variable "kms_master_key_id" {
  description = "KMS by default for SNS topic"
  default = "alias/aws/sns"
}

variable "required_tags" {
  default = {} 
}