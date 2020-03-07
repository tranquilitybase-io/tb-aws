
variable "aggregate_organization" {
  description = "Aggregate compliance data by organization"
  type        = bool
  default     = true
}

variable "config_tags" {
  description = "Required TAGS"
  default = {} 
}

variable "config_name" {
  description = "Name of Config Service"
  default = ""
}

variable "region" {
  description = "Region to be attached to Authorization"
}

variable "authorization_account_id" {
  description = "Authorization Account ID - Required"
}

variable "policy_arn" {
  default = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}

