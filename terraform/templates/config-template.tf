# Get the access to the effective Account ID in which Terraform is working.
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {  
  log_archive_account_id = module.aws_lz_account_logarchive.account_id
  #data.aws_caller_identity.current.account_id  
  region = data.aws_region.current.name
  bucket_name = "aws-lz-s3-access-logs-${local.log_archive_account_id}-${local.region}"
  bucket_name_log = "aws-lz-s3-logs-${local.log_archive_account_id}-${local.region}"  
}

module "aws_lz_config_bucket"{
  source = "./templates/modules/config/config-s3-bucket"
  bucket_name = local.bucket_name
  bucket_name_log = local.bucket_name_log
  config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.account_id, (var.tag_key_name) = "config" }
}

module "aws_lz_config_iam"{
    source = "./templates/modules/config/config-iam"
    config_name = var.config_name
    config_logs_bucket = module.aws_lz_config_bucket.bucket_name_log
    config_logs_prefix = module.aws_lz_config_bucket.config_logs_prefix  
    log_archive_account_id = local.log_archive_account_id
    config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.account_id, (var.tag_key_name) = "config" }
}

module "aws_lz_config_service"{
  source = "./templates/modules/config/config-service"
  role_arn = module.aws_lz_config_iam.arn
  config_name = var.config_name
  config_logs_bucket = module.aws_lz_config_bucket.bucket_name_log
  config_logs_prefix = module.aws_lz_config_bucket.config_logs_prefix
}

module "aws_lz_config_aggregator"{
  source = "./templates/modules/config/config-aggregator"
  config_name = var.config_name
  config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.account_id, (var.tag_key_name) = "config" }
}

module "aws_lz_config_rules"{
  source = "./templates/modules/config/config-rules"
  recorder_main = module.aws_lz_config_service.recorder_main
  delivery_channel = module.aws_lz_config_service.delivery_channel
}
