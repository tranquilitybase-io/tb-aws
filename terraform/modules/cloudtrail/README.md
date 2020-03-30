# GFT AWS LZ CloudTrail Service Terraform module

Usage: Terraform module which activates CloudTrail Service for each SandBox Account.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| bucket\_account\_id | bucket\_account\_id | `any` | n/a | yes |
| bucket\_arn | The name of the S3 Bucket Log | `any` | n/a | yes |
| bucket\_name | The name of the S3 Bucket Log | `any` | n/a | yes |
| cloudtrail\_name | The name of the AWS CloudTrail instance. | `any` | n/a | yes |
| enable\_log\_file\_validation | enable\_log\_file\_validation TRUE - FALSE | `bool` | `true` | no |
| enable\_logging | enable\_logging TRUE - FALSE | `bool` | `true` | no |
| include\_global\_events | Indicates whether the trail is publishing events from global services, such as IAM, to the log files. | `bool` | `true` | no |
| logs\_retencion\_days | Specifies the number of days you want to retain CloudTrail log events in the CloudWatch Logs. | `number` | `14` | no |
| multi\_region\_trail | is\_multi\_region\_trail TRUE - FALSE | `bool` | `true` | no |
| organization\_trail | organization\_trail | `bool` | `false` | no |
| region | The name of the Region | `any` | n/a | yes |
| required\_tags | Required tags | `map` | `{}` | no |
| s3\_log\_prefix | S3 prefix | `any` | n/a | yes |
| sns\_topic\_arn | Topic ARN | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_cloudwatch\_log\_group\_arn | CloudWatch Log Group ARN |
| aws\_cloudwatch\_log\_group\_id | CloudWatch Log Group ID |
| aws\_cloudwatch\_log\_group\_name | CloudWatch Log Group name |
| cloudtrail\_id | CloudTrail ID |
| cloudtrail\_name | CloudTrail name |

