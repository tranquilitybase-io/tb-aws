# GFT AWS LZ RAM Service Terraform module

Usage: Terraform module which activates RAM resource share service.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| ram\_allow\_external\_principals | RAM allow external principals | `bool` | `true` | no |
| ram\_name | RAM service name | `string` | `""` | no |
| ram\_principals | RAM principals | `string` | `""` | no |
| ram\_resource\_arn | RAM resource ARN | `string` | `""` | no |
| ram\_tags | Required Tags | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| ram\_principal\_association\_arn | The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma |
| ram\_resource\_share\_id | The Amazon Resource Name (ARN) of the resource share |

