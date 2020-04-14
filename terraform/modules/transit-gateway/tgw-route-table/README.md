# GFT AWS LZ Transit Gateway Route Terraform module

Usage: Terraform module which creates Transit Gateway route in Network Account.

## Terraform versions  
Only Terraform 0.12 is supported.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| route\_table\_name | Tag Name for Route Table | `string` | `""` | no |
| tags | Tags for attachment VPC | `map` | `{}` | no |
| tgw\_id | Transit Gateway ID | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| default\_association\_route\_table | Boolean whether this is the default association route table for the EC2 Transit Gateway |
| default\_propagation\_route\_table | Boolean whether this is the default propagation route table for the EC2 Transit Gateway |
| tgw\_route\_table\_id | EC2 Transit Gateway Route Table identifier |

