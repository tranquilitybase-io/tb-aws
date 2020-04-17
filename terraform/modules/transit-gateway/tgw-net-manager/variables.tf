variable "global_network_name" {
  description = "Name for Global Network"
  default = ""
}

variable "global_network_description" {
  description = "Description value for Global Network"
  default = "Global Network to monitor AWS LZ Transit Gateway"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "Region Name"
  default = ""
}