# Get the access to the effective Account ID in which Terraform is working.
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "aws_lz_organization_main" {
  source = "./modules/organizations"
  create_lz_organization = true 
}

module "aws_lz_ou_awsgftlz" {
  source = "./modules/organizations"

  ou_name = "AWS-GFT-LZ"
  ou_parent_id = module.aws_lz_organization_main.roots[0].id
}

module "aws_lz_ou_company" {
  source = "./modules/organizations"

  ou_name = "ACME"
  ou_parent_id = module.aws_lz_ou_awsgftlz.ou_id
}

module "aws_lz_ou_core" {
  source = "./modules/organizations"

  ou_name = "Core OU"
  ou_parent_id = module.aws_lz_ou_company.ou_id
}

#Sandbox OU for testing purpose
module "aws_lz_ou_sandbox" {
  source = "./modules/organizations"

  ou_name = "SandBox OU"
  ou_parent_id = module.aws_lz_ou_company.ou_id
}

#Sandbox DEV account for testing purpose
module "aws_lz_account_sandbox" {
  source = "./modules/organizations"
  
  org_account_name = var.aws_organizations_account_sandboxdev_name
  org_account_email = var.aws_organizations_account_sandboxdev_email
  account_role_name = var.org_admin_role
  org_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "organization" }
  account_parent_id = module.aws_lz_ou_sandbox.ou_id
}

#Sandbox PROD account for testing purpose
module "aws_lz_account_sandbox_prod" {
  source = "./modules/organizations"
  
  org_account_name = var.aws_organizations_account_sandboxprod_name
  org_account_email = var.aws_organizations_account_sandboxprod_email
  account_role_name = var.org_admin_role
  org_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "organization" }
  account_parent_id = module.aws_lz_ou_sandbox.ou_id
}

module "aws_lz_account_security" {
  source = "./modules/organizations"
  
  org_account_name = var.aws_organizations_account_security_name
  org_account_email = var.aws_organizations_account_security_email
  account_role_name = var.org_admin_role
  org_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "organization" }
  account_parent_id = module.aws_lz_ou_core.ou_id
}

module "aws_lz_account_logarchive" {
  source = "./modules/organizations"
  
  org_account_name = var.aws_organizations_account_logarchive_name
  org_account_email = var.aws_organizations_account_logarchive_email
  account_role_name = var.org_admin_role
  org_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "organization" }
  account_parent_id = module.aws_lz_ou_core.ou_id
}

module "aws_lz_account_sharedservices" {
  source = "./modules/organizations"
  
  org_account_name = var.aws_organizations_account_sharedservices_name
  org_account_email = var.aws_organizations_account_sharedservices_email
  account_role_name = var.org_admin_role
  org_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "organization" }
  account_parent_id = module.aws_lz_ou_core.ou_id
}

module "aws_lz_account_network" {
  source = "./modules/organizations"
  
  org_account_name = var.aws_organizations_account_network_name
  org_account_email = var.aws_organizations_account_network_email
  account_role_name = var.org_admin_role
  org_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "organization" }
  account_parent_id = module.aws_lz_ou_core.ou_id
}


module "aws_lz_policy_tagging" {
  source = "./modules/organizations"

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