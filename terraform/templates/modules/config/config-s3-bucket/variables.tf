data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {  
  account_id = data.aws_caller_identity.current.account_id  
  region = data.aws_region.current.name
  bucket_name = "aws-lz-s3-access-logs-${local.account_id}-${local.region}"
  bucket_name_log = "aws-lz-s3-logs-${local.account_id}-${local.region}"  
}


variable "config_logs_prefix" {
  description = "The S3 prefix for AWS Config logs."
  type        = string
  default = "config/"
}

variable "default_tags" {
  default = var.default_tags    
}

variable "bucket_name" {
  description = "The S3 prefix for S3 access bucket."
  type        = string
  default = local.bucket_name
}

variable "bucket_name_log" {
  description = "The S3 prefix for S3 bucket logs."
  type        = string
  default = local.bucket_name_log
}
