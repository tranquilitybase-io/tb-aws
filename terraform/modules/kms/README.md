# GFT AWS LZ KMS Service Terraform module

Usage: Terraform module which generates KMS key to be used as encryption algorithm in a S3 bucket.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| key\_description | KMS key Description | `string` | `""` | no |
| kms\_tags | Required Tags | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| key\_arn | KMS key ARN |
| key\_id | KMS key ID |

