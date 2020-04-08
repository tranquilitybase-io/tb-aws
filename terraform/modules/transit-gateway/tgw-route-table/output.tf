
output "tgw_route_table_id" {
  description = "EC2 Transit Gateway Route Table identifier"
  value       = element(concat(aws_ec2_transit_gateway_route_table.main.*.id, [""]), 0)
}

output "default_association_route_table" {
  description = "Boolean whether this is the default association route table for the EC2 Transit Gateway"
  value       = element(concat(aws_ec2_transit_gateway_route_table.main.*.default_association_route_table, [""]), 0)
}

output "default_propagation_route_table" {
  description = "Boolean whether this is the default propagation route table for the EC2 Transit Gateway"
  value       = element(concat(aws_ec2_transit_gateway_route_table.main.*.default_propagation_route_table, [""]), 0)
}