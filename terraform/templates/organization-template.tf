module "aws_lz_organization_main" {
  source = "./templates/modules/organizations"
  create_lz_organization = true 
}

module "aws_lz_account_sharedservices" {
  source = "./templates/modules/organizations"
  
  org_account_name = var.aws_organizations_account_sharedservices_name
  org_account_email = var.aws_organizations_account_sharedservices_email
  org_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = var.awslz_account_id, (var.tag_key_name) = "organization" }
  account_parent_id = module.aws_lz_ou_core.ou_id
}

module "aws_lz_account_logarchive" {
  source = "./templates/modules/organizations"
  
  org_account_name = var.aws_organizations_account_logarchive_name
  org_account_email = var.aws_organizations_account_logarchive_email
  org_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = var.awslz_account_id, (var.tag_key_name) = "organization" }
  account_parent_id = module.aws_lz_ou_core.ou_id
}

module "aws_lz_account_security" {
  source = "./templates/modules/organizations"
  
  org_account_name = var.aws_organizations_account_security_name
  org_account_email = var.aws_organizations_account_security_email
  org_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = var.awslz_account_id, (var.tag_key_name) = "organization" }
  account_parent_id = module.aws_lz_ou_core.ou_id
}

module "aws_lz_ou_core" {
  source = "./templates/modules/organizations"

  ou_name = "CoreOU"
  #ou_parent_id = module.aws_lz_organization_main.org_id
  ou_parent_id = module.aws_lz_organization_main.roots.0.id
}

module "aws_lz_policy_tagging" {
  source = "./templates/modules/organizations"

  policy_name = "Tagging"
  policy_description = "Tagging resources on AWS"
  policy_type = "TAG_POLICY"
  policy_content = <<CONTENT
{
    "tags": {
        "CostCenter": {
            "tag_key": {
                "@@assign": "CostCenter",
                "@@operators_allowed_for_child_policies": ["@@none"]
            }
        },
        "Project": {
            "tag_key": {
                "@@assign": "Project",
                "@@operators_allowed_for_child_policies": ["@@none"]
            }
        }
    }
}
CONTENT

}