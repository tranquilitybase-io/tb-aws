output "org_id" {
  value = concat(aws_organizations_organization.aws_lz_organization.*.id, [""])[0]
  description = "ID of the organization"
}

output "roots" {
  value = concat(aws_organizations_organization.aws_lz_organization.*.roots, [""])[0]
  description = "List of organization roots"
}

output "ou_id" {
  value = concat(aws_organizations_organizational_unit.aws_lz_ou.*.id, [""])[0]
  description = "Identifier of the organization unit"
}

output "account_arn" {
  value = concat(aws_organizations_account.aws_lz_account.*.arn, [""])[0]
  description = "ARN of the organization account"
}

output "account_id" {
  value = concat(aws_organizations_account.aws_lz_account.*.id, [""])[0]
  description = "Identifier of the organization account"
}

output "policy_arn" {
  value = concat(aws_organizations_policy.aws_lz_policy.*.arn, [""])[0]
  description = "ARN of the organization policy"
}

output "policy_id" {
  value = concat(aws_organizations_policy.aws_lz_policy.*.id, [""])[0]
  description = "Identifier of the organization policy"
}

output "org_accounts" {
  value = concat(aws_organizations_organization.aws_lz_organization.*.accounts, [""])[0]
  description = "List of organization accounts including the master account"
}

output "org_arn" {
  value = concat(aws_organizations_organization.aws_lz_organization.*.arn, [""])[0]
  description = "ARN of the organization"
}

output "master_account_arn" {
  value = concat(aws_organizations_organization.aws_lz_organization.*.master_account_arn, [""])[0]
  description = "ARN of the master account"
}

output "master_account_email" {
  value = concat(aws_organizations_organization.aws_lz_organization.*.master_account_email, [""])[0]
  description = "Email of the master account"
}

output "master_account_id" {
  value = concat(aws_organizations_organization.aws_lz_organization.*.master_account_id, [""])[0]
  description = "ID of the master account"
}

output "non_master_accounts" {
  value = concat(aws_organizations_organization.aws_lz_organization.*.non_master_accounts, [""])[0]
  description = "List of organization accounts excluding the master account"
}
