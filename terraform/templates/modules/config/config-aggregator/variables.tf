
variable "aggregate_organization" {
  description = "Aggregate compliance data by organization"
  type        = bool
  default     = true
}

variable "config_tags" {
  default = {} 
}

variable "config_name" {
  default = ""
}

variable "authorization_account_id" {
  description = "Authorization Account ID - Required"
}

variable "aggregator_name" {
  default = "${var.config_name}-aggregator"
}

variable "aggregator_role_name" {
  default = "${var.config_name}-aggregator-role"
}

