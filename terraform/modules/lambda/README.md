# GFT AWS LZ Lambda Serverless Service Terraform module

Usage: Terraform module which moves the notifications from member account to Shared Service account.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| code\_hash | Code Hash | `string` | n/a | yes |
| file\_name | Lambda function file | `string` | n/a | yes |
| function\_description | Description of the function | `string` | n/a | yes |
| function\_handler | Function entrypoint in the code | `string` | n/a | yes |
| function\_name | Lambda function name | `string` | n/a | yes |
| function\_role | IAM role attached to the Lambda Function | `string` | n/a | yes |
| function\_runtime | Function runtime image | `string` | n/a | yes |
| tags | Function tags | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| lambda\_zip\_inline\_arn | The Amazon Resource Name (ARN) identifying your Lambda Function |
| lambda\_zip\_inline\_invoke\_arn | The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws\_api\_gateway\_integration's uri |
| lambda\_zip\_inline\_qualified\_arn | The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true) |

