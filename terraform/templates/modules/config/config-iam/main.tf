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
        "Resource": "${var.bucket_log_arn}"
    },
    {
        "Sid": "AWSConfigBucketExistenceCheck",
        "Effect": "Allow",
        "Action": "s3:ListBucket",
        "Resource": "${var.bucket_log_arn}"
    },
    {
        "Sid": "AWSConfigBucketDelivery",
        "Effect": "Allow",
        "Action": "s3:PutObject",
        "Resource": "$${resource}",
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
    #bucket_arn = format("arn:aws:s3:::%s",var.config_logs_bucket)
    resource = format("%s/%s/AWSLogs/*/*",var.bucket_log_arn,var.config_logs_prefix)
  }
}

#var.log_archive_account_id,

# Allow IAM policy to assume the role for AWS Config
data "aws_iam_policy_document" "aws-config-role-policy" {
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
  name               = "${var.config_name}-iam-role"
  assume_role_policy = data.aws_iam_policy_document.aws-config-role-policy.json
  tags = var.config_tags
}

resource "aws_iam_policy_attachment" "managed-policy" {
  name       = "${var.config_name}-iam-managed-policy-attach"
  roles      = [aws_iam_role.main.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"  
}

resource "aws_iam_policy" "aws-config-policy" {
  name   = "${var.config_name}-iam-policy"
  policy = data.template_file.aws_config_policy.rendered  
}

resource "aws_iam_policy_attachment" "aws-config-policy" {
  name       = "${var.config_name}-iam-policy-attach"
  roles      = [aws_iam_role.main.name]
  policy_arn = aws_iam_policy.aws-config-policy.arn  
}

