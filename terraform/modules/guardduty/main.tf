#Enable GuardDuty on Master account
resource "aws_guardduty_detector" "detector" {
  enable = true
  finding_publishing_frequency = var.cloudwatch_notify_frequency
}


#POC/TODO Invite member accounts, see how can we do this dinamically

#Send invite
#resource "aws_guardduty_member" "memberInvite" {
#  detector_id = aws_guardduty_detector.detector.id
#  account_id = [module.aws_lz_organization_main.master_account_id, module.aws_lz_account_sharedservices.id,module.aws_lz_account_logarchive.id]
#  email = [module.aws_lz_organization_main.master_account_email, var.aws_organizations_account_logarchive_email,var.aws_organizations_account_sharedservices_email]
#  invite = var.invite_members
#  invitation_message = var.member_invite_message 
#  disable_email_notification = var.disable_email_notification
#}