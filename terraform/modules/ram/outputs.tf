output "ram_resource_share_id" {
  description = "The Amazon Resource Name (ARN) of the resource share"
  value       = element(concat(aws_ram_resource_share.aws_lz_ram_shared.*.id, [""]), 0)
}

output "ram_principal_association_arn" {
  description = "The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma"
  value       = element(concat(aws_ram_principal_association.aws_lz_ram_principal_association.*.id, [""]), 0)
}
