/*
* # GFT AWS LZ Customer Gateway Terraform module
*
* Usage: Terraform module which creates Customer Gateway resources in Network Account.
*
*/

resource "aws_customer_gateway" "main" {
  count = var.create_cgw ? 1 : 0

  bgp_asn    = var.bgn_asn
  ip_address = var.customer_ip_address
  type       = var.cgw_type

  tags = merge(
  {"Name" = format("%s", var.cgw_name)}, var.tags)
}