module "aws_lz_guardduty_master" {
  source = "./templates/modules/guardduty"
  cloudwatch_notify_frequency = var.finding_publishing_frequency
}

module "aws_lz_guardduty_master" {
  source = "./templates/modules/guardduty"
  region = "us-east-1"
  cloudwatch_notify_frequency = var.finding_publishing_frequency
}