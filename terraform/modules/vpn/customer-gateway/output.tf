output "cgw_id" {
  value = element(concat(aws_customer_gateway.main.*.id, [""]), 0)
  description = "Customer Gateway ID"
}

output "cgw_bgp_asn" {
  value = element(concat(aws_customer_gateway.main.*.bgp_asn, [""]), 0)
  description = "Customer Gateway BGP ASN"
}

output "cgw_customer_ip" {
  value = element(concat(aws_customer_gateway.main.*.ip_address, [""]), 0)
  description = "Customer IP Address"
}

output "cgw_type" {
  value = element(concat(aws_customer_gateway.main.*.type, [""]), 0)
  description = "Customer Gateway type"
}