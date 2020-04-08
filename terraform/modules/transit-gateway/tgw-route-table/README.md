# GFT AWS LZ Transit Gateway Route Terraform module

Usage: Terraform module which creates Transit Gateway route in Network Account.

## Terraform versions  
Only Terraform 0.12 is supported.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| attach\_id | TGW-VPC Attachment ID | `string` | `""` | no |
| destination\_cidr\_block | Destination CIDR Block | `string` | `""` | no |
| tgw\_id | Transit Gateway ID | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| tgw\_route\_id | EC2 Transit Gateway Route identifier |

