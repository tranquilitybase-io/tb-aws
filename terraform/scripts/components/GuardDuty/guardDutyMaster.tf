#Enable GuardDuty on Master account
resource "aws_guardduty_detector" "master" {
  enable = true
  finding_publishing_frequency = var.cloudwatch_notify_frecuency
}

#Send invite
resource "aws_guardduty_member" "memberInvite" {
  detector_id = aws_guardduty_detector.master.id
  account_id = ["000000000000","111"]
  email = "some@example.com"
  invite = true
  invitation_message = var.invitation_message 
}