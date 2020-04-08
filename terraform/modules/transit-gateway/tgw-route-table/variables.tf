

variable "corr" {
  description = "Tag Name for Route Table"
  default = ""
}

variable "tgw_id" {
  description = "Transit Gateway ID"
  default = ""
}

variable "tags" {
  description = "Tags for attachment VPC"
  default = {}
}