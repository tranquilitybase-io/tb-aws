## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| \_algorithm | Encryption algorithm for Findings bucket | `string` | `"aws:kms"` | no |
| \_config\_tags | n/a | `map` | `{}` | no |
| \_description | Key Description | `string` | `"Allow Guarduty to access bucket"` | no |
| \_s3\_guardduty\_policy\_description | Policy description for guardduty access to S3 | `string` | `"Allows Guardduty to write in S3 bucket"` | no |
| \_s3\_guardduty\_policy\_name | Policy name for guardduty access to S3 | `string` | `"AllowGuardduty"` | no |
| s3\_log\_prefix | The S3 prefix for AWS Config logs. | `string` | `"awslz"` | no |

## Outputs

No output.

