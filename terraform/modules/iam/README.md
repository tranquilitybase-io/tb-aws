# GFT AWS LZ IAM role and policy Service Terraform module

Usage: Generic Terraform module which handles IAM roles, policies and their attachment.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| assume\_role\_policy | Assume Role Policy | `string` | `""` | no |
| policy | Policy text | `string` | `""` | no |
| policy\_arn | Policy ARN | `string` | `""` | no |
| policy\_description | Policy Description | `string` | `""` | no |
| policy\_name | Policy Name | `string` | `""` | no |
| role\_name | Role Name | `string` | `""` | no |
| role\_policy\_attach | n/a | `bool` | n/a | yes |
| role\_tags | Required Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| create\_date | Create Date |
| force\_detach\_policies | Force detach policies |
| max\_session\_duration | Max Session Duration |
| path | Role path |
| policy\_arn | Policy ARN |
| policy\_id | Policy ID |
| role\_arn | Role ARN |
| role\_name | Role Name |
| unique\_id | ID of the role |

