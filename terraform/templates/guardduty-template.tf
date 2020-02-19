module "aws_lz_guardduty_master" {
  source = "./templates/modules/guard-duty"
  finding_publishing_frequency = var.cloudwatch_notify_frecuency
 # invite = var.invite_members
 # invitation_message = var.member_invite_message 
#  disable_email_notification =- var.disable_email_notification
}