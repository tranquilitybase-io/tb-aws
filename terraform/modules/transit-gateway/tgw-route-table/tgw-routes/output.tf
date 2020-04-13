
output "tgw_route_id" {
  description = "EC2 Transit Gateway Route identifier"
  value       = element(concat(aws_ec2_transit_gateway_route.aws_lz_tgw_route.*.id, [""]), 0)
}