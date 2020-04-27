output "worker_group_mgmt_one_id" {
  description = "ID for your security group."
  value       = concat(aws_security_group.worker_group_mgmt_one.*.id, [""])[0]
}

output "worker_group_mgmt_two_id" {
  description = "ID for your security group."
  value       = concat(aws_security_group.worker_group_mgmt_two.*.id, [""])[0]
}