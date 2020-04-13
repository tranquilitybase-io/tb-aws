# GFT AWS LZ Customer Gateway Terraform module

Usage: Terraform module which creates Customer Gateway resources in Network Account.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| bgn\_asn | BGN ASN number | `number` | `65000` | no |
| cgw\_name | Name of Customer Gateway | `any` | n/a | yes |
| cgw\_type | Type of customer gateway | `string` | `"ipsec.1"` | no |
| create\_cgw | Boolean to decide if customer gateway is created or not | `bool` | `false` | no |
| customer\_ip\_address | Customer IP address | `any` | n/a | yes |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cgw\_bgp\_asn | Customer Gateway BGP ASN |
| cgw\_customer\_ip | Customer IP Address |
| cgw\_id | Customer Gateway ID |
| cgw\_type | Customer Gateway type |

