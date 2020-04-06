# GFT AWS LZ Organization Terraform module

Usage: Terraform module which creates Organization and some admin accounts.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| account\_parent\_id | Account parent ID | `string` | `""` | no |
| account\_role\_name | Account Role Names | `string` | `""` | no |
| aws\_organizations\_enable\_policy\_types | AWS Organizations Enable Policy Types | `list(string)` | <pre>[<br>  "SERVICE_CONTROL_POLICY",<br>  "TAG_POLICY"<br>]</pre> | no |
| aws\_organizations\_feature\_set | AWS Organizations Feature Set | `string` | `"ALL"` | no |
| aws\_organizations\_service\_access\_principals | AWS Organizations Service Access Principals | `list(string)` | <pre>[<br>  "cloudtrail.amazonaws.com",<br>  "config.amazonaws.com",<br>  "ram.amazonaws.com"<br>]</pre> | no |
| create\_lz\_organization | Create AWS Organizations? | `bool` | `false` | no |
| org\_account\_email | AWS Organizations Account Email | `string` | `""` | no |
| org\_account\_name | AWS Organizations Account Name | `string` | `""` | no |
| org\_tags | Required tags | `map` | `{}` | no |
| ou\_name | Organization Unit Name | `string` | `""` | no |
| ou\_parent\_id | Organization parent ID | `string` | `""` | no |
| policy\_content | Policy Content | `string` | `""` | no |
| policy\_description | Policy Description | `string` | `""` | no |
| policy\_id | Policy ID | `string` | `""` | no |
| policy\_name | Policy Name | `string` | `""` | no |
| policy\_type | Policy Type | `string` | `""` | no |
| target\_id | Target ID | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| account\_arn | ARN of the organization account |
| account\_id | Identifier of the organization account |
| master\_account\_arn | ARN of the master account |
| master\_account\_email | Email of the master account |
| master\_account\_id | ID of the master account |
| non\_master\_accounts | List of organization accounts excluding the master account |
| org\_accounts | List of organization accounts including the master account |
| org\_arn | ARN of the organization |
| org\_id | ID of the organization |
| ou\_id | Identifier of the organization unit |
| policy\_arn | ARN of the organization policy |
| policy\_id | Identifier of the organization policy |
| roots | List of organization roots |

