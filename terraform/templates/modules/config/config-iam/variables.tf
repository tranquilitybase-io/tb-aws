
variable "config_logs_bucket" {    
    default = ""
}

variable "config_logs_prefix" { 
    default = ""
}

variable "bucket_log_arn" {
    description = "Bucket ARN of logging bucket"
}


variable "config_name" {  
    default = ""
}

variable "config_tags" {
  default = {} 
}

variable "bucket_account_id" {
    description = "Account ID for Bucket creator"
    default = ""
}