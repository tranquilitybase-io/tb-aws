
variable "create_cgw" {
  description = "Boolean to decide if customer gateway is created or not"
  type = bool
  default = false
}

variable "cgw_name" {
  description = "Name of Customer Gateway"
  default = "aws_lz_cgw"
}

variable "bgn_asn" {
  description = "BGN ASN number"
  type = number
  default = 65000
}

variable "customer_ip_address" {
  description = "Customer IP address"
  default = ""
}

variable "cgw_type" {
  description = "Type of customer gateway"
  default = "ipsec.1"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}