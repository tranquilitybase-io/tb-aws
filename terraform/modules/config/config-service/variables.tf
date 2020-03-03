
variable "config_logs_bucket" {    
    default = ""
}

variable "config_name" {  
    default = ""
}

variable "recorder_name" {  
    default = "recorder"
}

variable "config_tags" {
  default = {} 
}

variable "s3_log_prefix" { 
    default = ""
}

variable "role_arn" {
  description = "The ARN of role."
}

variable "kms_master_key_id" {
  description = "KMS by default for SNS topic"
  default = "alias/aws/sns"
}

variable "aws_config_delivery_channel_name" {
  description = "Name of Delivery Channel"
  default = "config_delivery_channel"
}

variable "config_delivery_frequency" {
  description = "The frequency with which AWS Config delivers configuration snapshots."
  default     = "Six_Hours"
}

variable "bucket_account_id" {
  description = "bucket_account_id"
}
