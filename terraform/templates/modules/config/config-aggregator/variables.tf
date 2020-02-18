
variable "aggregate_organization" {
  description = "Aggregate compliance data by organization"
  type        = bool
  default     = true
}

variable "default_tags" {
  default = var.default_tags
}

variable "config_name" {
  default = var.config_name
}