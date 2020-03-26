
##Get TGW Route Table info as ID
data "aws_ec2_transit_gateway_route_table" "aws_lz_tgw_default_route_table" {
  filter {
    name   = "default-association-route-table"
    values = ["true"]
  }

  filter {
    name   = "transit-gateway-id"
    values = [var.tgw_id]
  }
}