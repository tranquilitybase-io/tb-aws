variable "config_name" {
}

variable "config_logs_bucket" {  
}

variable "config_logs_prefix" {
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
