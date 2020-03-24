resource "aws_route" "r" {
  count = length(var.route_table)
  route_table_id         = var.route_table[count.index]
  destination_cidr_block = var.destination
  transit_gateway_id     = var.transit_gateway
}