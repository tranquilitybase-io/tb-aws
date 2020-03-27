output "tgw_attach_id" {
  description = "VPC Attachment ID"
  value       = element(concat(aws_ec2_transit_gateway_vpc_attachment.tgw_vpc_attachment.*.id, [""]), 0)
}