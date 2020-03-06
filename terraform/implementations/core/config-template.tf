

/* module "aws_lz_config_iam" {
    source = "./modules/config/config-iam"
    
     providers = {
    aws = aws.logarchive-account
    } 
    
    config_name = var.config_name
    config_logs_bucket = module.aws_lz_config_bucket.bucket_name_log
    log_bucket_arn = module.aws_lz_config_bucket.bucket_log_arn
    s3_log_prefix = var.s3_log_prefix
    bucket_account_id = local.log_archive_account_id
    config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.log_archive_account_id, (var.tag_key_name) = "config" }
} */


