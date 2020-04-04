# GFT AWS LZ SNS Topic Terraform module

Usage: Terraform module which creates SNS Topic.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| attach\_policy | Attach a custom policy to the SNS | `bool` | `false` | no |
| kms\_master\_key\_id | KMS by default for SNS topic | `string` | `"alias/aws/sns"` | no |
| policy | SNS Policy | `string` | `""` | no |
| required\_tags | Required Tags | `map` | `{}` | no |
| sns\_topic\_name | SNS Topic Name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| topic\_arn | SNS Topic ARN |
| topic\_name | SNS Topic Name |

