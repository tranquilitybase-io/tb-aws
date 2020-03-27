output "cloudtrail_id"{
  value = concat(aws_cloudtrail.cloudtrail_default.*.id, [""])[0]
  description = "CloudTrail ID"
}

output "cloudtrail_name"{
  value = concat(aws_cloudtrail.cloudtrail_default.*.name, [""])[0]
  description = "CloudTrail name"
}

output "aws_cloudwatch_log_group_id"{
  value = concat(aws_cloudwatch_log_group.log_group_default.*.id, [""])[0]
  description = "CloudWatch Log Group ID"
}

output "aws_cloudwatch_log_group_arn"{
  value = concat(aws_cloudwatch_log_group.log_group_default.*.arn, [""])[0]
  description = "CloudWatch Log Group ARN"
}

output "aws_cloudwatch_log_group_name"{
  value = concat(aws_cloudwatch_log_group.log_group_default.*.name, [""])[0]
  description = "CloudWatch Log Group name"
}
