#multiregion
#us-east-1,us-east-2,us-west-1,us-west-2,ap-east-1,ap-south-1,ap-northeast-2,ap-northeast-1,ap-southeast-1,ap-southeast-2,ca-central-1,eu-central-1,eu-west-1,eu-west-2,eu-west-3,eu-north-1,me-south-1,sa-east-1,

module "aws_lz_guardduty_master_REGION" {
  source = "./templates/modules/guardduty"
  cloudwatch_notify_frequency = var.finding_publishing_frequency
  providers = {aws = aws.alias}
}