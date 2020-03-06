
variable "bucket_name" {
  description = "The S3 Bucket Name source for findings bucket"
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

variable "kms_key" {
  description = "KMS Key"
  default = ""
}

variable "enc_algorithm"{  
  default = "aws:kms"
variable "bucket_name" {
    type = string
    default = ""
}
variable "s3_bucket_policy" {
    type = string
    default = ""
}