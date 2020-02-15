#Enable GuardDuty on Master account
resource "aws_guardduty_detector" "master" {
  enable = true
  finding_publishing_frequency = "FIFTEEN_MINUTES"
  depends_on = [aws_organizations_organization.aws_lz_organization]
}

#Send invite
resource "aws_guardduty_member" "memberInvite" {
  count = "1"
  detector_id = aws_guardduty_detector.master.id
  account_id = "000000000000"
  email = "some@example.com"
  invite = true
  invitation_message = "message" 
}