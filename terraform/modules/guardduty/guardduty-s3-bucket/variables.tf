
variable "findings_bucket_name" {
  description = "The S3 Bucket Name source for findings bucket"
  type        = string
}

variable "findings_config_tags" {
  default = {} 
}

variable "findings_versioning_enabled"{
  description = "Set versioning in S3 bucket"
  type        = bool
  default = true
}

variable "findings_acl_access_bucket" {
  description = "ACL value for Access Bucket"
  default = "log-delivery-write"
}

variable "findings_sse_aes256" {
  description = "Encryption AES256"
  default = "AES256"
}
