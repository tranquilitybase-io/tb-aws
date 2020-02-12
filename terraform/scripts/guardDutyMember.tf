#Enable GuardDuty on member
resource "aws_guardduty_detector" "member" {
  enable = true
  finding_publishing_frequency = "FIFTEEN_MINUTES"
  provider = aws.member_provider
}
#Accept invite
resource "aws_guardduty_invite_accepter" "memberAccepter" {
  depends_on = [aws_guardduty_member.memberInvite]
  provider = aws.member_provider
  detector_id = aws_guardduty_detector.member.id
  master_account_id = aws_guardduty_detector.master.account_id
}