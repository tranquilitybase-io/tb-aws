# GFT AWS LZ Config Aggregator Terraform module

Usage: Module to create an aggregator to set Config in a Multi Account environment. The aggregator will be set to all regions even futures region, also it will be attched to an Organization, so all the members of that Organization will be checked by the Config rules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aggregate\_organization | Aggregate compliance data by organization | `bool` | `true` | no |
| authorization\_account\_id | Authorization Account ID - Required | `string` | `""` | no |
| config\_name | Name of Config Service | `string` | `""` | no |
| config\_tags | Required TAGS | `map` | `{}` | no |
| region | Region to be attached to Authorization | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| aggregator\_name | Aggregator Name |

