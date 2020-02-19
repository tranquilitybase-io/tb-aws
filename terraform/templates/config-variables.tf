
variable "config_name" {
  description = "The name of the AWS Config instance."
  type        = string
  default = "aws-lz-config"
}

variable "config_logs_prefix" {
  description = "The S3 prefix for AWS Config logs."
  type        = string
  default = "config/"
}