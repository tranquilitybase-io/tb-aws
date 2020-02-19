locals {
  policy_id = coalescelist(aws_organizations_policy.aws_lz_policy.*.id, [var.policy_id])
}

resource "aws_organizations_organization" "aws_lz_organization" {
  count = var.create_lz_organization ? 1 : 0

  aws_service_access_principals = var.aws_organizations_service_access_principals
  enabled_policy_types = var.aws_organizations_enable_policy_types
  feature_set = var.aws_organizations_feature_set
}

resource "aws_organizations_account" "aws_lz_account" {
  count = length(var.org_account_name) > 0 ? 1 : 0
  
  name  = var.org_account_name
  email = var.org_account_email
  parent_id = var.account_parent_id
  tags = var.org_tags
}

resource "aws_organizations_organizational_unit" "aws_lz_ou" {
  count = length(var.ou_name) > 0 ? 1 : 0
  name      = var.ou_name
  #parent_id = var.ou_parent_id
  #parent_id   = aws_organizations_organization.root.0.id
  parent_id   = data.aws_organizations_organization.aws_lz_organization.id
}

resource "aws_organizations_policy" "aws_lz_policy" {
  count = length(var.policy_name) > 0 ? 1 : 0

  name = var.policy_name
  description = var.policy_description

  type = var.policy_type

  content = var.policy_content
}

resource "aws_organizations_policy_attachment" "aws_lz_pa" {
  count = length(var.target_id) > 0 ? length(var.target_id) : 0

  policy_id = local.policy_id[0]
  target_id = var.target_id[count.index]
}

