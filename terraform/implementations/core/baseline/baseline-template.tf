
### CONFIG SERVICE -->

### Topic for Config --->
module "aws_lz_config_sns_topic" {
  source = "./modules/snstopic"

  providers = {
    aws = aws.sandbox-account
  }

  sns_topic_name = var.config_topic_name
  required_tags  = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox_account_id, (var.tag_key_name) = "config" }
}
### <---


module "aws_lz_config_service" {
  source = "./modules/config/config-service"

  providers = {
    aws = aws.sandbox-account
  }

  config_name        = var.config_name
  config_logs_bucket = module.aws_lz_config_bucket.bucket_name_log
  s3_log_prefix      = module.aws_lz_config_bucket.s3_log_prefix
  topic_account_id   = local.sandbox_account_id
  sns_topic_arn      = module.aws_lz_config_sns_topic.topic_arn
  config_tags        = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox_account_id, (var.tag_key_name) = "config" }
}

/*
###Activate Config Service for Master Account
module "aws_lz_config_service_master" {
  source = "./modules/config/config-service"

  config_name        = var.config_name
  config_logs_bucket = module.aws_lz_config_bucket.bucket_name_log
  s3_log_prefix      = module.aws_lz_config_bucket.s3_log_prefix
  config_tags        = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.current_account_id, (var.tag_key_name) = "config" }
}
###
###Activate Config Aggregator for Master Account
module "aws_lz_config_aggregator" {
  source = "./modules/config/config-aggregator"

  config_name              = var.config_name
  region                   = local.region
  authorization_account_id = local.sandbox_account_id
  config_tags              = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox_account_id, (var.tag_key_name) = "config" }
}
###
*/

module "aws_lz_config_rules" {
  source           = "./modules/config/config-rules"

  providers = {
    aws = aws.sandbox-account
  }

  recorder_main    = module.aws_lz_config_service.recorder_main
  delivery_channel = module.aws_lz_config_service.delivery_channel
}
### CONFIG SERVICE <--

### CLOUDTRAIL SERVICE -->

### Topic for Config --->
module "aws_lz_cloudtrail_sns_topic" {
  source = "./modules/snstopic"

  providers = {
    aws = aws.sandbox-account
  }

  sns_topic_name = var.cloudtrail_topic_name
  required_tags  = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox_account_id, (var.tag_key_name) = "cloudtrail" }
}
### <---

module "aws_lz_cloudtrail" {
  source = "./modules/cloudtrail"

  providers = {
    aws = aws.sandbox-account
  }

  cloudtrail_name = var.cloudtrail_name
  bucket_name = module.aws_lz_config_bucket.bucket_name_log
  s3_log_prefix = module.aws_lz_config_bucket.s3_log_prefix
  bucket_arn = module.aws_lz_config_bucket.bucket_log_arn
  bucket_account_id = local.sandbox_account_id
  sns_topic_arn = module.aws_lz_cloudtrail_sns_topic.topic_arn
  region = local.region
  required_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox_account_id, (var.tag_key_name) = "cloudtrail" }
}
### CLOUDTRAIL SERVICE <--