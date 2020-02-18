variable "config_name" {
  default = var.config_name
}

variable "config_logs_bucket" {  
}

variable "config_logs_prefix" {
}

variable "role_arn" {
  description = "The ARN of role."
  type        = string
}