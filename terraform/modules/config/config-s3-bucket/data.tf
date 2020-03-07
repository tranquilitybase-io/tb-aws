#Bucket Policy for Config-Cloudtrail Services
data "template_file" "logarchive_bucket_policy" {
  template = <<JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "AWSConfigBucketPermissionsCheck",
        "Effect": "Allow",
        "Principal" : {
          "Service" : [
            "cloudtrail.amazonaws.com",
            "config.amazonaws.com"
          ]
        },
        "Action": "s3:GetBucketAcl",
        "Resource": "${module.aws_lz_config_bucket.bucket_log_arn}"
    },
    {
        "Sid": "AWSConfigBucketDelivery",
        "Effect": "Allow",
        "Principal" : {
          "Service" : [
            "cloudtrail.amazonaws.com",
            "config.amazonaws.com"
          ]
        },
        "Action": "s3:PutObject",
        "Resource": ["$${config_resource}","$${cloudtrail_resource}"],
        "Condition": {
          "StringLike": {
            "s3:x-amz-acl": "bucket-owner-full-control"
          }
        }
    }
  ]
}
JSON

  vars = {
    config_resource = format("%s/%s/AWSLogs/%s/Config/*",module.aws_lz_config_bucket.bucket_log_arn,module.aws_lz_config_bucket.s3_log_prefix,local.sandbox_account_id)
    cloudtrail_resource = format("%s/%s/AWSLogs/%s/CloudTrail/*",module.aws_lz_config_bucket.bucket_log_arn,module.aws_lz_config_bucket.s3_log_prefix,local.sandbox_account_id)
  }
}