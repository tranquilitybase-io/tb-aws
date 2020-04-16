## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aggregate\_topic\_name | Name of topic for Security Account | `string` | `"aws_lz_aggregate_security_sns_topic"` | no |
| file\_name | Lambda file name (with no extension) | `string` | `"guarduty_findings"` | no |
| function\_description | Function description | `string` | `"Function that will be triggered by CloudWatch events eith GuardDuty findings"` | no |
| function\_handler | Function entrypoint in the code | `string` | `"lambda_handler"` | no |
| function\_name | Name of the lambda function for guarduty findings | `string` | `"aws_lz_guarduty_findings_lambda"` | no |
| function\_runtime | Runtime for lambda execution | `string` | `"python3.8"` | no |
| guardduty\_topic\_name | Name of topic for guardduty findings notification | `string` | `"aws_lz_guardduty_sns_topic"` | no |
| lambda\_role\_name | Role that will be attached to the lambda function | `string` | `"AWSLZRoleForLambda"` | no |

## Outputs

No output.

