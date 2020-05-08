# GFT AWS LZ Transit Gateway VPC Attachment Terraform module

Usage: Terraform module which attaches a VPC with Transit Gateway.

## Terraform versions  
Only Terraform 0.12 is supported.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| attach\_name | Attachment Name | `string` | `""` | no |
| create\_attachment | Flag to create VPC Attachment | `bool` | `true` | no |
| subnets\_ids | Identifiers of subnets | `list(string)` | n/a | yes |
| tags | Tags for attachment VPC | `map` | `{}` | no |
| transit\_gateway\_id | Transit gateway Id | `string` | n/a | yes |
| vpc\_id | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| tgw\_attach\_id | VPC Attachment ID |

