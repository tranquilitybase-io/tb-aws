#Enable GuardDuty on Master account
resource "aws_guardduty_detector" "detector" {
  enable = var.enable_detector
  finding_publishing_frequency = var.cloudwatch_notify_frecuency
}

#Send invite
resource "aws_guardduty_member" "memberInvite" {
  detector_id = aws_guardduty_detector.detector.id
  account_id = 
  email = 
  invite = var.invite_members
  invitation_message = var.member_invite_message 
  disable_email_notification =- var.disable_email_notification
}

#Accept invite
resource "aws_guardduty_invite_accepter" "memberAccepter" {
  count = var.auto_accept_invites == true ? 1 : 0
  detector_id = aws_guardduty_detector.member.id
  master_account_id = module.aws_lz_account_security.account_id