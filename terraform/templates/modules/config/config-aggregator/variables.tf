
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