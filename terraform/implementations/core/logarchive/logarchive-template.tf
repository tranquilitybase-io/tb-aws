locals {
  log_archive_account_id = module.aws_lz_account_logarchive.account_id
  region = data.aws_region.current.name
  bucket_name = "aws-lz-s3-access-logs-${local.log_archive_account_id}-${local.region}"
  bucket_name_log = "aws-lz-s3-logs-${local.log_archive_account_id}-${local.region}"  
}

module "aws_lz_config_bucket" {
  source = "./modules/config/config-s3-bucket"
  
  providers = {
    aws = aws.logarchive-account
  }
   
  bucket_name = local.bucket_name
  bucket_name_log = local.bucket_name_log
  s3_log_prefix = var.s3_log_prefix
  config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.log_archive_account_id, (var.tag_key_name) = "config" }
}

data "aws_iam_role" "AdminLogArchiveRole" {
  name = var.org_admin_role

  providers = {
      aws = aws.logarchive-account
  }
}

/*
module "aws_lz_iam_attach_policy_logarchive"{
    source = "./modules/iam"
    policy_attach_name = "Attach logarchive policy on network role"
    policy_attach_roles = [module.aws_lz_iam_role_network.role_name]
    policy_arn = module.aws_lz_iam_policy_network.policy_arn

    providers = {
      aws = aws.logarchive-account
    }
}*/
