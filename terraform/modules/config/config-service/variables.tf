
variable "config_logs_bucket" {
  description = "Logging Bucket Name"
    default = ""
}

variable "config_name" {
  description = "Config Service Name"
    default = ""
}

variable "config_tags" {
  description = "Required tags"
  default = {} 
}

variable "s3_log_prefix" {
  description = "S3 logging bucket prefix"
    default = ""
}

variable "sns_topic_arn" {
  description = "SNS topic ARN"
  default = ""
}

variable "config_delivery_frequency" {
  description = "The frequency with which AWS Config delivers configuration snapshots."
  default     = "Six_Hours"
}