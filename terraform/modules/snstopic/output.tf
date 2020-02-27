
output "topic_name" {
    value = aws_sns_topic.sns_topic_default.id
}

output "topic_arn" {
    value = aws_sns_topic.sns_topic_default.arn
}