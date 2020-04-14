
output "event_id" {
  value = aws_cloudwatch_event_rule.event_rule.id
  description = "The name of the event"
}

output "event_arn" {
  value = aws_cloudwatch_event_rule.event_rule.arn
  description = "The Amazon Resource Name (ARN) identifying your event"
}