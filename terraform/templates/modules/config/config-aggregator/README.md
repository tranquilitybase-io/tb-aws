
## Usage

**Module to create an aggregator to set Config in a Multi Account environment. The aggregator will be set to all regions even futures region, also it will be attched to an Organization, so all the members of that Organization will be checked by the Config rules.**

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aggregate\_organization | Aggregate compliance data by organization | `bool` | `true` | yes |
| config\_name | The name of the AWS Config instance. | `string` | `"aws-config"` | no |
| config\_aggregator\_name | The name of the aggregator. | `string` | `"organization"` | no |
| config\_tags | Required TAGS used by all the resources | `string` | `"config_tags"` | no |



## Outputs
Aggregator Name

