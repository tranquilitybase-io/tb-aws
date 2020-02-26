data "aws_iam_policy_document" "aws-config-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com","cloudtrail.amazonaws.com"]
    }

    effect = "Allow"
  }
}

module "aws_lz_iam_role_security" {
    source = "./modules/iam"
    name = var.security_role_name
    assume_role_policy = data.aws_iam_policy_document.aws-config-role-policy.json
    role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "action-role" }
}

module "aws_lz_iam_role_logarchive" {
    source = "./modules/iam"
    name = var.logarchive_role_name
    assume_role_policy = data.aws_iam_policy_document.aws-config-role-policy.json
    role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "action-role" }
}

module "aws_lz_iam_role_sharedservices" {
    source = "./modules/iam"
    name = var.sharedservices_role_name
    assume_role_policy = data.aws_iam_policy_document.aws-config-role-policy.json
    role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "action-role" }
}

module "aws_lz_iam_role_network" {
    source = "./modules/iam"
    name = var.network_role_name
    assume_role_policy = data.aws_iam_policy_document.aws-config-role-policy.json
    role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "action-role" }
}