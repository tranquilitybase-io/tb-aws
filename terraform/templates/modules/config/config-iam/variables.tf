
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

variable "log_archive_account_id" { 
    description = "Log Archive Account ID"
}
