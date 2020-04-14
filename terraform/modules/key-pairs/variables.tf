variable "key_name" {
  description = "Key name to use in AWS"
  type        = string
}

variable "public_key" {
  description = "Key pair generate in the deployment process"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to the key pair"
  type        = map(string)
  default     = {}
}
