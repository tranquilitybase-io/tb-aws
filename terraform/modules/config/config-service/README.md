# GFT AWS LZ Config Service Terraform module

Usage: Terraform module which activates Config Service for each SandBox Account.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| config\_delivery\_frequency | The frequency with which AWS Config delivers configuration snapshots. | `string` | `"Six_Hours"` | no |
| config\_logs\_bucket | Logging Bucket Name | `string` | `""` | no |
| config\_name | Config Service Name | `string` | `""` | no |
| config\_tags | Required tags | `map` | `{}` | no |
| s3\_log\_prefix | S3 logging bucket prefix | `string` | `""` | no |
| sns\_topic\_arn | SNS topic ARN | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| delivery\_channel\_id | Delivery Channel ID |
| delivery\_channel\_name | Delivery Channel name |
| recorder\_id | Recorder ID |
| recorder\_name | Recorder name |

