
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

variable "role_arn" {
  description = "The ARN of role."
  type        = string
}

variable "config_delivery_frequency" {
  description = "The frequency with which AWS Config delivers configuration snapshots."
  default     = "Six_Hours"
  type        = string
}
