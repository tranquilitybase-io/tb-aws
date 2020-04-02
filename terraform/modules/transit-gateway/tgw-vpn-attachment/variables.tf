
variable "create_vpn_connection" {
  description = "Boolean to decide if vpn connection is created or not"
  type = bool
  default = false
}

variable "vpn_attach_name" {
  description = "VPN Attachment Name"
}

variable "cgw_id" {
  description = "Customer Gateway ID"
}

variable "tgw_id" {
  description = "Transit Gateway ID"
}

variable "cgw_type" {
  description = "Customer Gateway type"
  default = "ipsec.1"
}

variable "cgw_static_route" {
  description = "Static Route ?"
  type = bool
  default = true
}

variable "tags" {
  description = "Tags for attachment VPC"
  default = {}
}