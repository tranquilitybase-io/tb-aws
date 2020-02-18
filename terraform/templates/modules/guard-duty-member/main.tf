#Enable GuardDuty on member account
resource "aws_guardduty_detector" "detector" {
  enable = true
  finding_publishing_frequency = var.cloudwatch_notify_frecuency
}

#Accept invite
resource "aws_guardduty_invite_accepter" "memberAccepter" {
  count = var.auto_accept_invites == true ? 1 : 0
  detector_id = aws_guardduty_detector.member.id
  master_account_id = module.aws_lz_account_security.account_id