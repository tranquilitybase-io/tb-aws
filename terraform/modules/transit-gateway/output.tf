// aws_ec2_transit_gateway
output "tgw_arn" {
  description = "EC2 Transit Gateway Amazon Resource Name (ARN)"
  value       = element(concat(aws_ec2_transit_gateway.aws_lz_tgw.*.arn, [""]), 0)
}

output "tgw_id" {
  description = "EC2 Transit Gateway identifier"
  value       = element(concat(aws_ec2_transit_gateway.aws_lz_tgw.*.id, [""]), 0)
}

output "tgw_owner_id" {
  description = "Identifier of the AWS account that owns the EC2 Transit Gateway"
  value       = element(concat(aws_ec2_transit_gateway.aws_lz_tgw.*.owner_id, [""]), 0)
}

