/*
* # GFT AWS LZ Cloudwatch Event Service Terraform module
*
* Usage: Terraform module which creates an Event rule and target for Cloudwatch
*/

resource "aws_cloudwatch_event_rule" "event_rule" {
  name        = var.event_name
  description = var.event_description

  event_pattern = var.event_pattern
}

resource "aws_cloudwatch_event_target" "event_targer" {
  rule      = var.event_name
  arn       = var.target_arn
}