# GFT AWS LZ S3 Bucket Terraform module

Usage: Module to create a S3 bucket to store logs files from GuardDuty.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| acl\_access\_bucket | ACL value for Access Bucket | `string` | `"log-delivery-write"` | no |
| bucket\_name | Bucket Name | `string` | `""` | no |
| config\_tags | Required TAGS | `map` | `{}` | no |
| enc\_algorithm | SSE Algorithm | `string` | `"aws:kms"` | no |
| kms\_key | KMS Key | `string` | `""` | no |
| versioning\_enabled | Set versioning in S3 bucket | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_name | Bucket Name |
| bucket\_name\_arn | Bucket ARN |

