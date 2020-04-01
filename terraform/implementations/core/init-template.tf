#Data source declarations
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {state = "available"}

data "aws_iam_policy_document" "aws_lz_assume_role_security" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.security_account_id}:root"]
    }

    effect = "Allow"
  }
}

locals {
  current_account_id = data.aws_caller_identity.current.account_id
  logarchive_account_id = module.aws_lz_account_logarchive.account_id
  sandbox_account_id = module.aws_lz_account_sandbox.account_id
  sandbox2_account_id = module.aws_lz_account_sandbox_prod.account_id
  security_account_id = module.aws_lz_account_security.account_id
  network_account_id = module.aws_lz_account_network.account_id
  sharedservices_account_id = module.aws_lz_account_sharedservices.account_id
  region = data.aws_region.current.name
  primary_az = data.aws_availability_zones.available.names[0]
  secondary_az = data.aws_availability_zones.available.names[1]
  bucket_name = "aws-lz-s3-access-logs-${local.logarchive_account_id}-${local.region}"
  bucket_name_log = "aws-lz-s3-logs-${local.logarchive_account_id}-${local.region}"  
  region_findings = data.aws_region.current.name
  bucket_name_findings = "aws-lz-s3-guardduty-findings-${local.logarchive_account_id}-${local.region}"
  ### SECURITY ROLES VALUES
  security_role_name = "SecurityAdminRole"
  security_role_name_audit = "SecurityAuditRole"
  administrator_access_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  read_only_access_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

provider "aws" {
  version = "~> 2.48"
}

provider "aws" {
  version = "~> 2.48"
  alias = "sandbox-account-2"
  assume_role {
    role_arn = "arn:aws:iam::${module.aws_lz_account_sandbox_prod.account_id}:role/${var.org_admin_role}" 
  }
}

provider "aws" {
  version = "~> 2.48"
  alias = "sandbox-account"
  assume_role {
    role_arn = "arn:aws:iam::${module.aws_lz_account_sandbox.account_id}:role/${var.org_admin_role}" 
  }
}

provider "aws" {
  version = "~> 2.48"
  alias = "security-account"
  assume_role {
    role_arn = "arn:aws:iam::${module.aws_lz_account_security.account_id}:role/${var.org_admin_role}" 
  }
}

provider "aws" {
  version = "~> 2.48"
  alias = "logarchive-account"
  assume_role {
    role_arn = "arn:aws:iam::${module.aws_lz_account_logarchive.account_id}:role/${var.org_admin_role}"
  }
}

provider "aws" {
  version = "~> 2.48"
  alias = "sharedservices-account"
  assume_role {
    role_arn = "arn:aws:iam::${module.aws_lz_account_sharedservices.account_id}:role/${var.org_admin_role}"
  }
}

provider "aws" {
  version = "~> 2.48"
  alias = "network-account"
  assume_role {
    role_arn = "arn:aws:iam::${module.aws_lz_account_network.account_id}:role/${var.org_admin_role}"
  }
}

terraform {
  required_version = ">= 0.12.20"
  backend "s3" {
    bucket          = "control-terraform-states-aws-lz-v01"
    key             = "terraform/terraform.tfstate"
    dynamodb_table  = "terraform-states"
  }
}

provider "local" {
  version = "~> 1.4"
}

provider "null" {
  version = "~> 2.1"
}
