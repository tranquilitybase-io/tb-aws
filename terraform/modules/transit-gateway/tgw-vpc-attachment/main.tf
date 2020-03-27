/*
* # GFT AWS LZ Transit Gateway VPC Attachment Terraform module
*
* Usage: Terraform module which attaches a VPC with Transit Gateway.
*
* ## Terraform versions
* Only Terraform 0.12 is supported.
*/


resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_vpc_attachment" {
  count = length(var.transit_gateway_id) > 0 ? 1 : 0
  subnet_ids         = var.subnets_ids
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = var.vpc_id

  tags = merge(
  {
    "Name" = var.attach_name
  },
  var.tags
  )
}