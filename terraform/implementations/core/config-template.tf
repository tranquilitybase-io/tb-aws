
locals {
  #log_archive_account_id = module.aws_lz_account_logarchive.account_id
  region = data.aws_region.current.name
  bucket_name = "aws-lz-s3-access-logs-${local.current_account_id}-${local.region}"
  bucket_name_log = "aws-lz-s3-logs-${local.current_account_id}-${local.region}"  
}

module "aws_lz_config_bucket" {
  source = "./modules/config/config-s3-bucket"
  
  providers = {
    aws = aws.logarchive-account
  }
   
  bucket_name = local.bucket_name
  bucket_name_log = local.bucket_name_log
  s3_log_prefix = var.s3_log_prefix
  config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.current_account_id, (var.tag_key_name) = "config" }
}

module "aws_lz_config_iam" {
    source = "./modules/config/config-iam"

    providers = {
      aws = aws.logarchive-account
    }

    config_name = var.config_name
    config_logs_bucket = module.aws_lz_config_bucket.bucket_name_log
    log_bucket_arn = module.aws_lz_config_bucket.bucket_log_arn
    s3_log_prefix = var.s3_log_prefix
    bucket_account_id = local.current_account_id
    config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.current_account_id, (var.tag_key_name) = "config" }
}

module "aws_lz_config_service" {
  source = "./modules/config/config-service"
  role_arn = module.aws_lz_config_iam.role_arn
  config_name = var.config_name
  config_logs_bucket = module.aws_lz_config_bucket.bucket_name_log
  s3_log_prefix = var.s3_log_prefix
  config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.current_account_id, (var.tag_key_name) = "config" }
}

module "aws_lz_config_aggregator" {
  source = "./modules/config/config-aggregator"
  config_name = var.config_name
  region = local.region
  authorization_account_id = local.current_account_id
  config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.current_account_id, (var.tag_key_name) = "config" }
}

module "aws_lz_config_rules" {
  source = "./modules/config/config-rules"
  recorder_main = module.aws_lz_config_service.recorder_main
  delivery_channel = module.aws_lz_config_service.delivery_channel
}
