
# CloudTrail Module

module "aws_lz_cloudtrail" {
  source = "./modules/cloudtrail"
  cloudtrail_name = var.cloudtrail_name
  bucket_name = module.aws_lz_config_bucket.bucket_name_log
  bucket_arn = module.aws_lz_config_bucket.bucket_log_arn
  bucket_account_id = local.current_account_id
  s3_log_prefix = module.aws_lz_config_bucket.s3_log_prefix
  region = data.aws_region.current.name
  required_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.current_account_id, (var.tag_key_name) = "cloudtrail" }  
}
