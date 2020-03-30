# GFT AWS LZ VPC Route Terraform module

Usage: Terraform module which creates VPC custom route.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| destination | CIDR destionation | `string` | `""` | no |
| route\_table | Route table where the route will be added | `list` | `[]` | no |
| transit\_gateway | The transit gateway Id ehre traffic is routed | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| custom\_route\_id | Route Table identifier and destination |

