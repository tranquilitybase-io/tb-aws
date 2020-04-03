output "vpn_attach_id" {
  value = element(concat(aws_vpn_connection.main.*.id, [""]), 0)
  description = "The amazon-assigned ID of the VPN connection"
}

output "vpn_attach_cgw_config" {
  value = element(concat(aws_vpn_connection.main.*.customer_gateway_configuration, [""]), 0)
  description = "The configuration information for the VPN connection's customer gateway (in the native XML format)"
}

output "tgw_attach_id" {
  value = element(concat(aws_vpn_connection.main.*.transit_gateway_attachment_id, [""]), 0)
  description = "When associated with an EC2 Transit Gateway (transit_gateway_id argument), the attachment ID."
}

output "vpn_attach_tunnel1_addr" {
  value = element(concat(aws_vpn_connection.main.*.tunnel1_address, [""]), 0)
  description = "The public IP address of the first VPN tunnel"
}

output "vpn_attach_tunnel1_preshared_key" {
  value = element(concat(aws_vpn_connection.main.*.tunnel1_preshared_key, [""]), 0)
  description = "The preshared key of the first VPN tunnel"
}

output "tunnel1_cgw_inside_addr" {
  value = element(concat(aws_vpn_connection.main.*.tunnel1_cgw_inside_address, [""]), 0)
  description = "The RFC 6890 link-local address of the first VPN tunnel (Customer Gateway Side)"
}

output "vpn_attach_tunnel2_addr" {
  value = element(concat(aws_vpn_connection.main.*.tunnel2_address, [""]), 0)
  description = "The public IP address of the second VPN tunnel"
}

output "vpn_attach_tunnel2_preshared_key" {
  value = element(concat(aws_vpn_connection.main.*.tunnel2_preshared_key, [""]), 0)
  description = "The preshared key of the second VPN tunnel"
}

output "tunnel2_cgw_inside_addr" {
  value = element(concat(aws_vpn_connection.main.*.tunnel2_cgw_inside_address, [""]), 0)
  description = "The RFC 6890 link-local address of the second VPN tunnel (Customer Gateway Side)"
}
