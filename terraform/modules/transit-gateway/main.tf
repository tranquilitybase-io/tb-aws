
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

##########################
# Resource Access Manager
##########################
resource "aws_ram_resource_share" "aws_lz_ram_share" {
  count = var.create_tgw && var.share_tgw ? 1 : 0

  name                      = coalesce(var.ram_name, var.name)
  allow_external_principals = var.ram_allow_external_principals

  tags = merge(
  {
    "Name" = format("%s", coalesce(var.ram_name, var.name))
  },
  var.tags,
  var.ram_tags,
  )
}

resource "aws_ram_resource_association" "aws_lz_ram_association" {
  count = var.create_tgw && var.share_tgw ? 1 : 0

  resource_arn       = aws_ec2_transit_gateway.aws_lz_tgw[0].arn
  resource_share_arn = aws_ram_resource_share.aws_lz_ram_share[0].id
}

resource "aws_ram_principal_association" "aws_lz_ram_principal" {
  count = var.create_tgw && var.share_tgw ? length(var.ram_principals) : 0

  principal          = var.ram_principals[count.index]
  resource_share_arn = aws_ram_resource_share.aws_lz_ram_share[0].arn
}
