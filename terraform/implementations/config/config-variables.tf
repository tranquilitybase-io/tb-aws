
variable "config_name" {
  description = "The name of the AWS Config instance."
  type        = string
  default = "aws-lz-config"
}

variable "config_tags" {
  default = {} 
}