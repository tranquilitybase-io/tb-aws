/*
* # GFT AWS LZ Transit Gateway Route Terraform module
*
* Usage: Terraform module which creates Transit Gateway route in Network Account.
*
* ## Terraform versions
* Only Terraform 0.12 is supported.
*/

locals {
  tgw_route_table_id = var.route_table_id=="default" ? data.aws_ec2_transit_gateway_route_table.aws_lz_tgw_default_route_table.id:var.route_table_id
}

resource "aws_ec2_transit_gateway_route" "aws_lz_tgw_route" {
  count = length(var.tgw_id) > 0 ? 1 : 0

  destination_cidr_block         = var.destination_cidr_block
  transit_gateway_attachment_id  = var.attach_id
  transit_gateway_route_table_id = local.tgw_route_table_id
}