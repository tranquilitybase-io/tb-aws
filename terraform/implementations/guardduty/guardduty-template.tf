#multiregion
#us-east-1,us-east-2,us-west-1,us-west-2,ca-central-1,eu-central-1,eu-west-1,eu-west-2,eu-west-3,eu-north-1,sa-east-1,

module "aws_lz_guardduty_master_REGION" {
  source = "./templates/modules/guardduty"
  cloudwatch_notify_frequency = var.finding_publishing_frequency
  providers = {aws = aws.alias}
}