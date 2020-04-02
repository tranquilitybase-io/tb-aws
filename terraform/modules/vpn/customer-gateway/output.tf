output "cgw_id" {
  value = aws_customer_gateway.main.id
  description = "Customer Gateway ID"
}

output "cgw_bgp_asn" {
  value = aws_customer_gateway.main.bgp_asn
  description = "Customer Gateway BGP ASN"
}

output "cgw_customer_ip" {
  value = aws_customer_gateway.main.ip_address
  description = "Customer IP Address"
}

output "cgw_type" {
  value = aws_customer_gateway.main.type
  description = "Customer Gateway type"
}