
resource "aws_ec2_transit_gateway" "aws_lz_tgw" {
  count = var.create_tgw ? 1 : 0

  description                     = coalesce(var.description, var.name)
  amazon_side_asn                 = var.amazon_side_asn
  default_route_table_association = var.enable_default_route_table_association ? "enable" : "disable"
  default_route_table_propagation = var.enable_default_route_table_propagation ? "enable" : "disable"
  auto_accept_shared_attachments  = var.enable_auto_accept_shared_attachments ? "enable" : "disable"
  vpn_ecmp_support                = var.enable_vpn_ecmp_support ? "enable" : "disable"
  dns_support                     = var.enable_dns_support ? "enable" : "disable"

  tags = merge(
  {
    "Name" = format("%s", var.name)
  },
  var.tags,
  var.tgw_tags,
  )
}

data "aws_ec2_transit_gateway_route_table" "aws_lz_tgw_route_table" {
  filter {
    name   = "default-association-route-table"
    values = ["true"]
  }

  filter {
    name   = "transit-gateway-id"
    values = [aws_ec2_transit_gateway.aws_lz_tgw.id]
  }
}

resource "aws_ec2_transit_gateway_route" "aws_lz_tgw_route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = module.egress-vpc-twg-attachment.tgw_attach_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.aws_lz_tgw_route_table.id

  tags = merge(
  {
    "Name" = "aws_lz_tgw_egress_route"
  },
  var.tags,
  var.tgw_tags,
  )
}