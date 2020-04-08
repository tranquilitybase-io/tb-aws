# GFT AWS LZ GuardDuty Service Terraform module

Usage: Terraform module which activates GuardDuty Service, and attach the bucket policy for each SandBox Account.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| bucket\_arn | S3 Bucket ARN | `string` | `""` | no |
| bucket\_name | S3 Bucket Name | `string` | `""` | no |
| policy | Bucket Policy | `string` | `""` | no |
| policy\_description | Bucket Policy Description | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| guardduty\_bucket\_policy\_id | Bucket Policy ID |

