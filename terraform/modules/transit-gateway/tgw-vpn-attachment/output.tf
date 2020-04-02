output "vpn_attach_id" {
  value = aws_vpn_connection.main.id
  description = "The amazon-assigned ID of the VPN connection"
}

output "vpn_attach_cgw_config" {
  value = aws_vpn_connection.main.customer_gateway_configuration
  description = "The configuration information for the VPN connection's customer gateway (in the native XML format)"
}

output "tgw_attach_id" {
  value = aws_vpn_connection.main.transit_gateway_attachment_id
  description = "When associated with an EC2 Transit Gateway (transit_gateway_id argument), the attachment ID."
}

output "vpn_attach_tunnel1_addr" {
  value = aws_vpn_connection.main.tunnel1_address
  description = "The public IP address of the first VPN tunnel"
}

output "vpn_attach_tunnel1_preshared_key" {
  value = aws_vpn_connection.main.tunnel1_preshared_key
  description = "The preshared key of the first VPN tunnel"
}

output "tunnel1_cgw_inside_addr" {
  value = aws_vpn_connection.main.tunnel1_cgw_inside_address
  description = "The RFC 6890 link-local address of the first VPN tunnel (Customer Gateway Side)"
}

output "vpn_attach_tunnel2_addr" {
  value = aws_vpn_connection.main.tunnel2_address
  description = "The public IP address of the second VPN tunnel"
}

output "vpn_attach_tunnel2_preshared_key" {
  value = aws_vpn_connection.main.tunnel2_preshared_key
  description = "The preshared key of the second VPN tunnel"
}

output "tunnel2_cgw_inside_addr" {
  value = aws_vpn_connection.main.tunnel2_cgw_inside_address
  description = "The RFC 6890 link-local address of the second VPN tunnel (Customer Gateway Side)"
}
