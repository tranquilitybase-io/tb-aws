# GFT AWS LZ Transit Gateway Network Manager Service Terraform module

Usage: Generic Terraform module to Enable TGW Network Manager Service.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| global\_network\_description | Description value for Global Network | `string` | `"Global Network to monitor AWS LZ Transit Gateway"` | no |
| global\_network\_name | Name for Global Network | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| globalnet\_json\_output | Output string with the information of Global Network |

