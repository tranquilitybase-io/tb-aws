## Usage

**Module to activate AWS Config Service, also is created a topic to send notifications to SNS subscriptions**

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| config\_name | The name of the AWS Config instance. | `string` | `"aws-config"` | no |
| config\_tags | Required TAGS used by all the resources. | `string` | `"config_tags"` | no |
| config\_logs\_bucket | The S3 bucket for AWS Config Access logs. | `string` | n/a | yes |
| config\_logs\_bucket_logs | The S3 bucket for AWS Config logs. | `string` | n/a | yes |
| config\_logs\_prefix | The S3 prefix for AWS Config logs. | `string` | `"config"` | no |
| config\_role_arn | The ARN role from IAM module. | `string` | `""` | yes |
| config\_delivery\_frequency | The frequency with which AWS Config delivers configuration snapshots. | `string` | `"Six_Hours"` | no |

## Output
"recorder_main"
"delivery_channel"