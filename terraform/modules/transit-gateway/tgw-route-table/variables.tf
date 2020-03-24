

variable "tgw_id" {
  description = "TGW ID"
  default = ""
}

variable "attach_id" {
  description = "VPC Attach with TGW ID"
  default = ""
}

// Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}