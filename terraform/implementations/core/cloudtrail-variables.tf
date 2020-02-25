
variable "cloudtrail_name" {
  description = "The name of the AWS CloudTrail instance."
  default = "aws_lz_cloudtrail"
}

variable "s3_log_prefix" {
  description = "S3 prefix"
  default = "cloudtrail"
}

variable "required_tags" {
  default = {} 
}