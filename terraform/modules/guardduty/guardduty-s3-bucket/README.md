## Usage

**Module to create a S3 bucket to store logs files from Config and Cloudtrail, the bucket is encrypted at rest using "AES256" as algorithm. The module create 2 buckets one for access and another with logging activated**


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| config\_name | The name of the AWS Config instance. | `string` | `"aws-config"` | no |
| config\_tags | Required TAGS used by all the resources. | `string` | `"config_tags"` | no |
| config\_logs\_bucket | The S3 bucket for AWS Config Access logs. | `string` | n/a | yes |
| config\_logs\_bucket_logs | The S3 bucket for AWS Config logs. | `string` | n/a | yes |
| config\_logs\_prefix | The S3 prefix for AWS Config logs. | `string` | `"config"` | no |

## Output
"bucket_name"
"bucket_name_log"
"s3_log_prefix"
