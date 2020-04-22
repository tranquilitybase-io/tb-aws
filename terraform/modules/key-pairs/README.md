# GFT AWS LZ Key Pairs Service Terraform module

Usage: Generic Terraform module to create AWS key pairs in order to using EC2 intances.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| key\_name | Key name to use in AWS | `string` | n/a | yes |
| public\_key | Key pair generate in the deployment process | `string` | n/a | yes |
| tags | A map of tags to add to the key pair | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| fingerprint | The MD5 public key fingerprint as specified in section 4 of RFC 4716 |
| key\_name | The key pair name |
| key\_pair\_id | The key pair ID |

