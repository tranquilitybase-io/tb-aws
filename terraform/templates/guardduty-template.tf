module "aws_lz_guardduty_master" {
  source = "./templates/modules/guardduty"
  finding_publishing_frequency = var.cloudwatch_notify_frequency
}