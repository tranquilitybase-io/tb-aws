
variable "aggregate_topic_name" {
  default = "aws_lz_aggregate_security_sns_topic"
  description = "Name of topic for Security Account"
}


############
variable "security_role_name"{
  default = "SecurityAdminRole"
  description = "Name of the Security admin role to be assumed"
}