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
        "Resource": "${aws_s3_bucket.s3_log.arn}"
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
        "Resource": ["$${config_resource}"],
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
    config_resource = format("%s/%s/AWSLogs/*/*",aws_s3_bucket.s3_log.arn,var.s3_log_prefix)
  }
}