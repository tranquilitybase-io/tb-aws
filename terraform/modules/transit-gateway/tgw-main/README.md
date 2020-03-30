# GFT AWS LZ Transit Gateway Terraform module

Usage: Terraform module which creates Transit Gateway resources in Network Account.

## Terraform versions  
Only Terraform 0.12 is supported.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| amazon\_side\_asn | The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN. | `string` | `"64512"` | no |
| create\_tgw | Controls if TGW should be created (it affects almost all resources) | `bool` | `true` | no |
| description | Description of the EC2 Transit Gateway | `string` | n/a | yes |
| enable\_auto\_accept\_shared\_attachments | Whether resource attachment requests are automatically accepted | `bool` | `false` | no |
| enable\_default\_route\_table\_association | Whether resource attachments are automatically associated with the default association route table | `bool` | `true` | no |
| enable\_default\_route\_table\_propagation | Whether resource attachments automatically propagate routes to the default propagation route table | `bool` | `true` | no |
| enable\_dns\_support | Should be true to enable DNS support in the TGW | `bool` | `true` | no |
| enable\_vpn\_ecmp\_support | Whether VPN Equal Cost Multipath Protocol support is enabled | `bool` | `true` | no |
| name | Name to be used on all the resources as identifier | `string` | `""` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| tgw\_tags | Additional tags for the TGW | `map(string)` | `{}` | no |
| tgw\_vpc\_attachment\_tags | Additional tags for VPC attachments | `map(string)` | `{}` | no |
| vpc\_attachments | Maps of maps of VPC details to attach to TGW. Type 'any' to disable type validation by Terraform. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| tgw\_arn | EC2 Transit Gateway Amazon Resource Name (ARN) |
| tgw\_id | EC2 Transit Gateway identifier |
| tgw\_owner\_id | Identifier of the AWS account that owns the EC2 Transit Gateway |

