
variable "cloudtrail_name" {
  description = "The name of the AWS CloudTrail instance."
  default = "aws_lz_cloudtrail"
}

variable "required_tags" {
  default = {} 
}