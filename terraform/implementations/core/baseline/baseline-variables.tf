
variable "config_name" {  
    default = "aws_lz_config"
    description = "Config Service name"
}

variable "config_topic_name" {
  default = "aws_lz_config_sns_topic"
  description = "Name of topic for Config service"
}


variable "cloudtrail_topic_name" {
  default = "aws_lz_cloudtrail_sns_topic"
  description = "Name of topic for Config service"
}