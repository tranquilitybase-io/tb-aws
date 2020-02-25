The following AWS Config Rules are supported:

* acm-certificate-expiration-check: Ensure ACM Certificates in your account are marked for expiration within the specified number of days.

* approved-amis-by-tag: Checks whether running instances are using specified AMIs.
* cloudtrail-enabled: Ensure CloudTrail is enabled.

* cloud-trail-encryption-enabled: Ensure CloudTrail is configured to use server side encryption (SSE) with AWS KMS or CMK encryption.

* cloud-trail-log-file-validation-enabled: Checks whether AWS CloudTrail creates a signed digest file with logs.

* multi-region-cloud-trail-enabled: Ensure that there is at least one multi-region AWS CloudTrail enabled.

* ec2-encrypted-volumes: Evaluates whether EBS volumes that are in an attached state are encrypted.

* ec2-volume-inuse-check: Checks whether EBS volumes are attached to EC2 instances.

* eip_attached: Checks whether all EIP addresses that are allocated to a VPC are attached to EC2 or in-use ENIs.

* guardduty-enabled-centralized: Checks whether Amazon GuardDuty is enabled in your AWS account and region.

* iam-password-policy: Ensure the account password policy for IAM users meets the specified requirements.

* iam-user-no-policies-check: Ensure that none of your IAM users have policies attached; IAM users must inherit permissions from IAM groups or roles.

* iam-group-has-users-check: Checks whether IAM groups have at least one IAM user.

* instances-in-vpc: Ensure all EC2 instances run in a VPC.

* required-tags: Checks if resources are deployed with configured tags.

* root-account-mfa-enabled: Ensure root AWS account has MFA enabled.

* rds-instance-public-access-check: Checks whether the Amazon Relational Database Service (RDS) instances are not publicly accessible.

* rds-snapshots-public-prohibited: Checks if Amazon Relational Database Service (Amazon RDS) snapshots are public.

* rds-storage-encrypted: Checks whether storage encryption is enabled for your RDS DB instances.

* s3-bucket-public-write-prohibited: Checks that your S3 buckets do not allow public write access.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acm\_days\_to\_expiration | Specify the number of days before the rule flags the ACM Certificate as noncompliant. | `number` | `14` | no |
| ami\_required\_tag\_key\_value | Tag/s key and value which AMI has to have in order to be compliant: Example: key1:value1,key2:value2 | `string` | `""` | no |
| check\_acm\_certificate\_expiration\_check | Enable acm-certificate-expiration-check rule | `bool` | `true` | no |
| check\_approved\_amis\_by\_tag | Enable approved-amis-by-tag rule | `bool` | `false` | no |
| check\_cloud\_trail\_encryption | Enable cloud-trail-encryption-enabled rule | `bool` | `false` | no |
| check\_cloud\_trail\_log\_file\_validation | Enable cloud-trail-log-file-validation-enabled rule | `bool` | `false` | no |
| check\_cloudtrail\_enabled | Enable cloudtrail-enabled rule | `bool` | `true` | no |
| check\_ec2\_encrypted\_volumes | Enable ec2-encrypted-volumes rule | `bool` | `true` | no |
| check\_ec2\_volume\_inuse\_check | Enable ec2-volume-inuse-check rule | `bool` | `true` | no |
| check\_eip\_attached | Enable eip-attached rule | `bool` | `false` | no |
| check\_guard\_duty | Enable guardduty-enabled-centralized rule | `bool` | `false` | no |
| check\_iam\_group\_has\_users\_check | Enable iam-group-has-users-check rule | `bool` | `true` | no |
| check\_iam\_password\_policy | Enable iam-password-policy rule | `bool` | `true` | no |
| check\_iam\_user\_no\_policies\_check | Enable iam-user-no-policies-check rule | `bool` | `true` | no |
| check\_instances\_in\_vpc | Enable instances-in-vpc rule | `bool` | `true` | no |
| check\_multi\_region\_cloud\_trail | Enable multi-region-cloud-trail-enabled rule | `bool` | `false` | no |
| check\_rds\_public\_access | Enable rds-instance-public-access-check rule | `bool` | `false` | no |
| check\_rds\_snapshots\_public\_prohibited | Enable rds-snapshots-public-prohibited rule | `bool` | `true` | no |
| check\_rds\_storage\_encrypted | Enable rds-storage-encrypted rule | `bool` | `true` | no |
| check\_required\_tags | Enable required-tags rule | `bool` | `false` | no |
| check\_root\_account\_mfa\_enabled | Enable root-account-mfa-enabled rule | `bool` | `false` | no |
| check\_s3\_bucket\_public\_write\_prohibited | Enable s3-bucket-public-write-prohibited rule | `bool` | `true` | no |
| password\_max\_age | Number of days before password expiration. | `number` | `90` | no |
| password\_min\_length | Password minimum length. | `number` | `14` | no |
| password\_require\_lowercase | Require at least one lowercase character in password. | `bool` | `true` | no |
| password\_require\_numbers | Require at least one number in password. | `bool` | `true` | no |
| password\_require\_symbols | Require at least one symbol in password. | `bool` | `true` | no |
| password\_require\_uppercase | Require at least one uppercase character in password. | `bool` | `true` | no |
| password\_reuse\_prevention | Number of passwords before allowing reuse. | `number` | `24` | no |