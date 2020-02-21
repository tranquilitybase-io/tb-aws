
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
    default = "$${config_name}-iam-role"
}

variable "iam_managed_policy_attachment_name" {
    description = "Name of Managed Policy to be attached to IAM Role"
    default = "$${config_name}-iam-managed-policy-attachment"
}

variable "aws_iam_policy_name" {
    description = "Name of IAM policy"
    default = "$${config_name}-policy"
}