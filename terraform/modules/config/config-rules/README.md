# GFT AWS LZ Config Rules Terraform module

Usage: Terraform module which activates Config Rules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| acm\_days\_to\_expiration | Specify the number of days before the rule flags the ACM Certificate as noncompliant. | `number` | `14` | no |
| ami\_required\_tag\_key\_value | Tag/s key and value which AMI has to have in order to be compliant: Example: key1:value1,key2:value2 | `string` | `""` | no |
| check\_acm\_certificate\_expiration\_check | Enable acm-certificate-expiration-check rule | `bool` | `false` | no |
| check\_approved\_amis\_by\_tag | Enable approved-amis-by-tag rule | `bool` | `false` | no |
| check\_cloud\_trail\_encryption | Enable cloud-trail-encryption-enabled rule | `bool` | `false` | no |
| check\_cloud\_trail\_log\_file\_validation | Enable cloud-trail-log-file-validation-enabled rule | `bool` | `false` | no |
| check\_cloudtrail\_enabled | Enable cloudtrail-enabled rule | `bool` | `false` | no |
| check\_ec2\_encrypted\_volumes | Enable ec2-encrypted-volumes rule | `bool` | `false` | no |
| check\_ec2\_volume\_inuse\_check | Enable ec2-volume-inuse-check rule | `bool` | `false` | no |
| check\_eip\_attached | Enable eip-attached rule | `bool` | `false` | no |
| check\_guard\_duty | Enable guardduty-enabled-centralized rule | `bool` | `true` | no |
| check\_iam\_group\_has\_users\_check | Enable iam-group-has-users-check rule | `bool` | `false` | no |
| check\_iam\_password\_policy | Enable iam-password-policy rule | `bool` | `false` | no |
| check\_iam\_user\_no\_policies\_check | Enable iam-user-no-policies-check rule | `bool` | `false` | no |
| check\_instances\_in\_vpc | Enable instances-in-vpc rule | `bool` | `false` | no |
| check\_multi\_region\_cloud\_trail | Enable multi-region-cloud-trail-enabled rule | `bool` | `false` | no |
| check\_rds\_public\_access | Enable rds-instance-public-access-check rule | `bool` | `false` | no |
| check\_rds\_snapshots\_public\_prohibited | Enable rds-snapshots-public-prohibited rule | `bool` | `false` | no |
| check\_rds\_storage\_encrypted | Enable rds-storage-encrypted rule | `bool` | `false` | no |
| check\_required\_tags | Enable required-tags rule | `bool` | `false` | no |
| check\_root\_account\_mfa\_enabled | Enable root-account-mfa-enabled rule | `bool` | `true` | no |
| check\_s3\_bucket\_public\_write\_prohibited | Enable s3-bucket-public-write-prohibited rule | `bool` | `false` | no |
| config\_max\_execution\_frequency | The maximum frequency with which AWS Config runs evaluations for a rule. | `string` | `"TwentyFour_Hours"` | no |
| delivery\_channel | Delivery Channel | `string` | `""` | no |
| password\_max\_age | Number of days before password expiration. | `number` | `90` | no |
| password\_min\_length | Password minimum length. | `number` | `14` | no |
| password\_require\_lowercase | Require at least one lowercase character in password. | `bool` | `true` | no |
| password\_require\_numbers | Require at least one number in password. | `bool` | `true` | no |
| password\_require\_symbols | Require at least one symbol in password. | `bool` | `true` | no |
| password\_require\_uppercase | Require at least one uppercase character in password. | `bool` | `true` | no |
| password\_reuse\_prevention | Number of passwords before allowing reuse. | `number` | `24` | no |
| recorder\_main | Recorder | `string` | `""` | no |
| required\_tags | A map of required resource tags. Format is tagNKey, tagNValue, where N is int. Values are optional. | `map(string)` | `{}` | no |
| required\_tags\_resource\_types | Resource types to check for tags. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| required\_tags\_rule\_arn | The ARN of the required-tags config rule. |

