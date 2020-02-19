variable "config_name" {
  default = ""
}

variable "bucket_name" {
  description = "The S3 Bucket Name source for log bucket"
  type        = string
}

variable "bucket_name_log" {
  description = "The S3 Bucket Name for log."
}

variable "config_logs_prefix" {
  description = "The S3 prefix for AWS Config logs."
}

variable "role_arn" {
  description = "The ARN of role."
  type        = string
}

variable "config_tags" {
  default = {} 
}

variable "config_delivery_frequency" {
  description = "The frequency with which AWS Config delivers configuration snapshots."
  default     = "Six_Hours"
  type        = string
}
