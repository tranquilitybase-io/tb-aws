#multiregion
#us-east-1,us-east-2,us-west-1,

module "aws_lz_guardduty_master_REGION" {
  source = "./templates/modules/guardduty"
  cloudwatch_notify_frequency = var.finding_publishing_frequency
  providers = {aws = aws.alias}
}