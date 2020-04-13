/*
* # GFT AWS LZ Transit Gateway Route Terraform module
*
* Usage: Terraform module which creates Transit Gateway route in Network Account.
*
* ## Terraform versions
* Only Terraform 0.12 is supported.
*/

resource "aws_ec2_transit_gateway_route_table" "main" {
  count = length(var.tgw_id) > 0 ? 1 : 0
  transit_gateway_id = var.tgw_id
  tags = merge( {"Name" = format("%s", var.route_table_name)}, var.tags )
}