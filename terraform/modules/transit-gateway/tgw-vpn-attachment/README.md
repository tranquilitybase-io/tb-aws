# GFT AWS LZ Transit Gateway VPN attachment Terraform module

Usage: Terraform module which attaches a VPC with Transit Gateway.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cgw\_id | Customer Gateway ID | `any` | n/a | yes |
| cgw\_static\_route | Static Route ? | `bool` | `true` | no |
| cgw\_type | Customer Gateway type | `string` | `"ipsec.1"` | no |
| create\_vpn\_connection | Boolean to decide if vpn connection is created or not | `bool` | `false` | no |
| tags | Tags for attachment VPC | `map` | `{}` | no |
| tgw\_id | Transit Gateway ID | `any` | n/a | yes |
| vpn\_attach\_name | VPN Attachment Name | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| tgw\_attach\_id | When associated with an EC2 Transit Gateway (transit\_gateway\_id argument), the attachment ID. |
| tunnel1\_cgw\_inside\_addr | The RFC 6890 link-local address of the first VPN tunnel (Customer Gateway Side) |
| tunnel2\_cgw\_inside\_addr | The RFC 6890 link-local address of the second VPN tunnel (Customer Gateway Side) |
| vpn\_attach\_cgw\_config | The configuration information for the VPN connection's customer gateway (in the native XML format) |
| vpn\_attach\_id | The amazon-assigned ID of the VPN connection |
| vpn\_attach\_tunnel1\_addr | The public IP address of the first VPN tunnel |
| vpn\_attach\_tunnel1\_preshared\_key | The preshared key of the first VPN tunnel |
| vpn\_attach\_tunnel2\_addr | The public IP address of the second VPN tunnel |
| vpn\_attach\_tunnel2\_preshared\_key | The preshared key of the second VPN tunnel |

