
output "topic_name" {
    value = concat(aws_sns_topic.sns_topic_default.*.name, [""])[0]
    description = "SNS Topic Name"
}

output "topic_arn" {
    value = concat(aws_sns_topic.sns_topic_default.*.arn, [""])[0]
    description = "SNS Topic ARN"
}