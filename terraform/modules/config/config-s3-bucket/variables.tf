
variable "bucket_name" {
  description = "The S3 Bucket Name source for log bucket"
  type        = string
}

variable "bucket_name_log" {
  description = "The S3 Bucket Name for log."
  type        = string
}

variable "config_logs_prefix" {
  description = "The S3 prefix for AWS Config logs."
  type        = string  
}

variable "config_tags" {
  default = {} 
}

variable "versioning_enabled"{
  description = "Set versioning in S3 bucket"
  type        = bool
  default = true
}

variable "acl_access_bucket" {
  description = "ACL value for Access Bucket"
  default = "log-delivery-write"
}

variable "acl_logs_bucket" {
  description = "ACL value for Logs Bucket"
  default = "private"
}

variable "sse_aes256" {
  description = "Encryption AES256"
  default = "AES256"
}
