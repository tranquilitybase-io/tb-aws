# Get the access to the effective Account ID in which Terraform is working.
data "aws_caller_identity" "current" {}

locals {  
  account_id = data.aws_caller_identity.current.account_id
}

module "aws_lz_config_bucket"{
  source = "./templates/modules/config/config-s3-bucket"
  default_tags {
    AccountID   = local.account_id
  }
}

module "aws_lz_config_iam"{
    source = "./templates/modules/config/config-iam"
    config_logs_bucket = module.aws_lz_config_bucket.bucket_name_log    
    default_tags {
      AccountID = local.account_id
    }
}

module "aws_lz_config_service"{
  source = "./templates/modules/config/config-service"
  role_arn = module.aws_lz_config_iam.arn
  config_logs_bucket = module.aws_lz_config_bucket.bucket_name_log
  default_tags {
    AccountID   = local.account_id
  }
}

module "aws_lz_config_aggregator"{
  source = "./templates/modules/config/config-aggregator"
  default_tags {
    AccountID   = local.account_id
  }
}

module "aws_lz_config_rules"{
  source = "./templates/modules/config/config-rules"
  recorder_main = module.aws_lz_config_service.recorder_main
  delivery_channel = module.config-service.delivery_channel
}
