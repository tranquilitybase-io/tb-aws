locals {
  #log_archive_account_id = module.aws_lz_account_logarchive.account_id
  region_findings = data.aws_region.current.name
  bucket_name_findings = "aws-lz-s3-guardduty-findings" 
}

module "aws_lz_guardduty_bucket" {
  source = "./modules/guardduty/guardduty-s3-bucket"
  
  providers = {
    aws = aws.logarchive-account
  }
 
  bucket_name = local.bucket_name_findings
  config_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.current_account_id, (var.tag_key_name) = "config" }
}