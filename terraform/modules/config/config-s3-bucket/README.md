# GFT AWS LZ S3 Bucket Terraform module

Usage: Module to create a S3 bucket to store logs files from Config and CloudTrail, the bucket is encrypted at rest using "AES256" as algorithm. The module create 2 buckets one for access and another with logging activated.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| acl\_access\_bucket | ACL value for Access Bucket | `string` | `"log-delivery-write"` | no |
| acl\_logs\_bucket | ACL value for Logs Bucket | `string` | `"private"` | no |
| bucket\_name | The S3 Bucket Name source for log bucket | `string` | `""` | no |
| bucket\_name\_log | The S3 Bucket Name for log. | `string` | `""` | no |
| config\_tags | Required Tags | `map` | `{}` | no |
| s3\_log\_prefix | The S3 prefix for AWS Config logs. | `string` | `""` | no |
| sse\_aes256 | Encryption AES256 | `string` | `"AES256"` | no |
| versioning\_enabled | Set versioning in S3 bucket | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_log\_arn | Logging Bucket ARN |
| bucket\_name | Bucket Name |
| bucket\_name\_arn | Bucket ARN |
| bucket\_name\_log | Logging Bucket Name |
| s3\_log\_prefix | S3 Log Prefix |

