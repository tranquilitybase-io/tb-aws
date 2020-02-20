module "aws_lz_guardduty_master" {
  source = "./templates/modules/guardduty"
  cloudwatch_notify_frequency = "SIX_HOURS"
}