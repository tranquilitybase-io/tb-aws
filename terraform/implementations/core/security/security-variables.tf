
variable "aggregate_topic_name" {
  default = "aws_lz_aggregate_security_sns_topic"
  description = "Name of topic for Security Account"
}


############
variable "security_role_name"{
  default = "SecurityAdminRole_"
  description = "Name of the Security admin role to be assumed"
}

variable "policy_attach_security_admin"{
  default = "Security_role_attachment_"
}

variable "administrator_access_arn"{
  default = "arn:aws:iam::aws:policy/AdministratorAccess"
}