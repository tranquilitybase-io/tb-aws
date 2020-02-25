output "master_detector_id" {
  value = aws_guardduty_detector.detector.id
  description = "Master GuardDuty detector Id"
}