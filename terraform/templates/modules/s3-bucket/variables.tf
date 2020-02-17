variable "bucket_name" {
  description = "Bucket Name"
  type        = string
}

variable "config_logs_prefix" {  
  default = var.config_logs_prefix
}

variable "default_tags" {
  default = var.default_tags    
}