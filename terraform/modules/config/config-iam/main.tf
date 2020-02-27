# Allow the AWS Config role to deliver logs to configured S3 Bucket.
# Derived from IAM Policy document found at https://docs.aws.amazon.com/config/latest/developerguide/s3-bucket-policy.html

data "template_file" "aws_config_policy" {
  template = <<JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "AWSConfigBucketPermissionsCheck",
        "Effect": "Allow",
        "Action": "s3:GetBucketAcl",
        "Resource": "${var.log_bucket_arn}"
    },
    {
        "Sid": "AWSConfigBucketDelivery",
        "Effect": "Allow",
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
    config_resource = format("%s/%s/AWSLogs/%s/Config/*",var.log_bucket_arn,var.s3_log_prefix,var.bucket_account_id)
    cloudtrail_resource = format("%s/%s/AWSLogs/%s/CloudTrail/*",var.log_bucket_arn,var.s3_log_prefix,var.bucket_account_id)
  }
}

# Allow IAM policy to assume the role for AWS Config
data "aws_iam_policy_document" "aws_config_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com","cloudtrail.amazonaws.com"]
    }

    effect = "Allow"
  }
}

#
# IAM
#
resource "aws_iam_role" "main" {
  name               = "${var.config_name}_${var.iam_role_name}"
  assume_role_policy = data.aws_iam_policy_document.aws_config_role_policy.json
  tags = var.config_tags
}

resource "aws_iam_policy_attachment" "managed_policy" {
  name       = "${var.config_name}_${var.managed_policy_name}"
  roles      = [aws_iam_role.main.name]
  policy_arn = var.iam_role_policy_arn  
}

resource "aws_iam_policy" "aws_config_policy" {
  name   = "${var.config_name}_${var.iam_policy_name}"
  policy = data.template_file.aws_config_policy.rendered  
}

resource "aws_iam_policy_attachment" "aws_config_policy" {
  name       = "${var.config_name}_${var.iam_policy_name}"
  roles      = [aws_iam_role.main.name]
  policy_arn = aws_iam_policy.aws_config_policy.arn
}

resource "aws_iam_policy_attachment" "cloudtrail_bucket_policy_attachment" {
  name       = "cloudtrail_bucket_policy_attachment"
  policy_arn = aws_iam_policy.aws_config_policy.arn
  roles      = [aws_iam_role.main.name]
}
