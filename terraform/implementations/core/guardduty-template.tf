module "aws_lz_guardduty_master" {
  source = "./modules/guardduty"
  cloudwatch_notify_frequency = var.finding_publishing_frequency
}