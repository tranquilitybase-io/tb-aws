provider "aws" {
  region = "${DEV_region}"
  access_key = "${CS_access_key}"
  secret_key = "${CS_secret_key}"
}

terraform {
  required_version = ">= 0.12.20"
}

provider "local" {
  version = "~> 1.4"
}

provider "null" {
  version = "~> 2.1"
}

module "aws_lz_organization_main" {
  source = "./components/organizations"
  create_lz_organization = true 
}

module "aws_lz_account_sharedservices" {
  source = "./components/organizations"
  
  org_account_name = var.aws_organizations_account_sharedservices_name
  org_account_email = var.aws_organizations_account_sharedservices_email
  org_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = var.awslz_account_id, (var.tag_key_name) = "organization" }
}

module "aws_lz_account_logarchive" {
  source = "./components/organizations"
  
  org_account_name = var.aws_organizations_account_logarchive_name
  org_account_email = var.aws_organizations_account_logarchive_email
  org_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = var.awslz_account_id, (var.tag_key_name) = "organization" }
  
}

module "aws_lz_ou_sharedservices" {
  source = "./components/organizations"

  ou_name = "Shared Services"
  ou_parent_id = module.aws_lz_organization_main.org_id
}

module "aws_lz_policy_tagging" {
  source = "./components/organizations"

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

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}