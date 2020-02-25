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

variable "bucket_account_id" { 
    description = "Log Archive Account ID"
}

variable "log_bucket_arn" { 
    default = ""
}

variable "iam_role_name" { 
    default = "iam_role"
}

variable "managed_policy_name" { 
    default = "managed_policy"
}

variable "iam_policy_name" { 
    default = "iam_policy"
}

variable "iam_policy_attachment_name" { 
    default = "iam_policy_attachment"
}

variable "iam_role_policy_arn" { 
    default = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}