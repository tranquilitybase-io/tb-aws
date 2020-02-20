
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

variable "iam_role_name" {
    description = "Name of IAM role"
    default = "${var.config_name}-iam-role"
}

variable "iam-managed-policy-attachment_name" {
    description = "Name of Managed Policy to be attached to IAM Role"
    default = "${var.config_name}-iam-managed-policy-attachment"
}

variable "aws_iam_policy_name" {
    description = "Name of IAM policy"
    default = "${var.config_name}-iam-policy"
}

variable "iam-policy-attachment_name" {
    description = "Name of IAM policy attached to IAM policy role"
    default = "${var.config_name}-iam-policy-attachment"
}