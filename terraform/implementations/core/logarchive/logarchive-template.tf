locals {
  log_archive_account_id = module.aws_lz_account_logarchive.account_id
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
  config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = log_archive_account_id, (var.tag_key_name) = "config" }
}