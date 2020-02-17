#Enable GuardDuty on Master account
resource "aws_guardduty_detector" "detector" {
  enable = true
  finding_publishing_frequency = var.cloudwatch_notify_frecuency
}

#Send invite
resource "aws_guardduty_member" "memberInvite" {
  detector_id = aws_guardduty_detector.detector.id
  account_id = module.aws_lz_account_security.
  email = 
  invite = var.invite_members
  invitation_message = var.member_invite_message 
}

#Accept invite
resource "aws_guardduty_invite_accepter" "memberAccepter" {
  count = var.auto_accept_invites == true ? 1 : 0
  depends_on = [aws_guardduty_member.memberInvite]
  detector_id = aws_guardduty_detector.member.id
  master_account_id = 
}