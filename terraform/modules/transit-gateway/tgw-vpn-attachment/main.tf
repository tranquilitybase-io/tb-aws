/*
* # GFT AWS LZ Transit Gateway VPN attachment Terraform module
*
* Usage: Terraform module which attaches a VPC with Transit Gateway.
*
*/

resource "aws_vpn_connection" "main" {
  count = var.create_vpn_connection ? 1 : 0

  customer_gateway_id = var.cgw_id
  transit_gateway_id  = var.tgw_id
  type                = var.cgw_type
  static_routes_only  = var.cgw_static_route

  tags = merge( { "Name" = var.vpn_attach_name }, var.tags )
}