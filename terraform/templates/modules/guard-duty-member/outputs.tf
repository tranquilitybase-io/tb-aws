output "master_detector_id" {
  value = concat(aws_organizations_account.aws_lz_account.*.arn, [""])[0]
  description = "Master GuardDuty detector Id"
}