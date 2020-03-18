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

// aws_ram_resource_share
output "ram_resource_share_id" {
  description = "The Amazon Resource Name (ARN) of the resource share"
  value       = element(concat(aws_ram_resource_share.aws_lz_ram_share.*.id, [""]), 0)
}

// aws_ram_principal_association
output "ram_principal_association_id" {
  description = "The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma"
  value       = element(concat(aws_ram_principal_association.aws_lz_ram_principal.*.id, [""]), 0)
}
