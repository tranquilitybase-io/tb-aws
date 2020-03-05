
variable "config_name" {
  description = "The name of the AWS Config instance."
  default = "aws_lz_config"
}

variable "s3_log_prefix" {
  description = "S3 prefix"
  default  = "awslz"
}

variable "config_tags" {
  default = {} 
}