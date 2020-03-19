output "cloudtrail_id"{
  value = concat(aws_cloudtrail.cloudtrail_default.*.id, [""])[0]
}

output "cloudtrail_name"{
  value = concat(aws_cloudtrail.cloudtrail_default.*.name, [""])[0]
}

output "aws_cloudwatch_log_group_id"{
value = concat(aws_cloudwatch_log_group.log_group_default.*.id, [""])[0]
}

output "aws_cloudwatch_log_group_arn"{
  value = concat(aws_cloudwatch_log_group.log_group_default.*.arn, [""])[0]
}

output "aws_cloudwatch_log_group_name"{
  value = concat(aws_cloudwatch_log_group.log_group_default.*.name, [""])[0]
}
