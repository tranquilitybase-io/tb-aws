locals {
  policy_id = coalescelist(aws_organizations_policy.policy.*.id, [var.policy_id])
}

resource "aws_organizations_account" "organization" {
  name  = var.aws_organizations_account_organization_name
  email = var.aws_organizations_account_organization_email
  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = var.awslz_account_id, (var.tag_key_name) = "organization" }
}
resource "aws_organizations_account" "sharedservices" {
  name  = var.aws_organizations_account_sharedservices_name
  email = var.aws_organizations_account_sharedservices_email
  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = var.awslz_account_id, (var.tag_key_name) = "organization" }
}
resource "aws_organizations_account" "logarchive" {
  name  = var.aws_organizations_account_logarchive_name
  email = var.aws_organizations_account_logarchive_email
  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = var.awslz_account_id, (var.tag_key_name) = "organization" }
}
resource "aws_organizations_account" "security" {
  name  = var.aws_organizations_account_security_name
  email = var.aws_organizations_account_security_email
  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = var.awslz_account_id, (var.tag_key_name) = "organization" }
}

resource "aws_organizations_organization" "org" {
  aws_service_access_principals = var.aws_organizations_service_access_principals
  feature_set = "ALL"
}

resource "aws_organizations_organizational_unit" "ou" {
  count = length(var.ou_name) > 0 ? 1 : 0

  name      = var.ou_name
  parent_id = var.ou_parent_id
}

resource "aws_organizations_policy" "policy" {
  count = length(var.policy_name) > 0 ? 1 : 0

  name = var.policy_name
  description = var.policy_description

  type = var.policy_type

  content = var.policy_content
}

resource "aws_organizations_policy_attachment" "policy_attachment" {
  count = length(var.target_id) > 0 ? length(var.target_id) : 0

  policy_id = local.policy_id[0]
  target_id = var.target_id[count.index]
}