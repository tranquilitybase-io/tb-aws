variable "config_logs_bucket" {  
    default = ""
}

variable "config_name" {}

variable "config_tags" {
  default = {} 
}

variable "s3_log_prefix" { 
    description = "The S3 prefix for AWS Config logs."
}

variable "bucket_account_id" { 
    description = "Log Archive Account ID"
}

variable "log_bucket_arn" { 
    default = ""
}

variable "config_role_arn" { 
    default = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}