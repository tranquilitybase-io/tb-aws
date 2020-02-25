
## Usage

**Note: This module sets up AWS IAM Roles and Policies, which are globally namespaced.**

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| config\_name | The name of the AWS Config instance. | `string` | `"aws-config"` | no |
| config\_tags | Required TAGS used by all the resources. | `string` | `"config_tags"` | no |
| config\_log_archive_account_id | Log Archive Account ID | `string` | `""` | yes |


## Outputs
Role ARN