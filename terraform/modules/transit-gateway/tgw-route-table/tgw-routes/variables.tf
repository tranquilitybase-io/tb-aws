

variable "tgw_id" {
  description = "Transit Gateway ID"
  default = ""
}

variable "attach_id" {
  description = "TGW-VPC Attachment ID"
  default = ""
}

variable "destination_cidr_block" {
  description = "Destination CIDR Block"
  default = ""
}