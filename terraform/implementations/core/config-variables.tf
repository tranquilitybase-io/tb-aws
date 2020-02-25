
variable "config_name" {
  description = "The name of the AWS Config instance."
  default = "aws_lz_config"
}

variable "config_tags" {
  default = {} 
}