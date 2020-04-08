/*
* # GFT AWS LZ Transit Gateway Route Terraform module
*
* Usage: Terraform module which creates Transit Gateway route in Network Account.
*
* ## Terraform versions
* Only Terraform 0.12 is supported.
*/

resource "aws_ec2_transit_gateway_route" "aws_lz_tgw_route" {
  count = length(var.tgw_id) > 0 ? 1 : 0

  destination_cidr_block         = var.destination_cidr_block
  transit_gateway_attachment_id  = var.attach_id
  transit_gateway_route_table_id = data.aws_ec2_transit_gateway_route_table.aws_lz_tgw_default_route_table.id
}