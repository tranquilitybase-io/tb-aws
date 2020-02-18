# Get the access to the effective Account ID in which Terraform is working.
data "aws_caller_identity" "current" {}

locals {  
  account_id = data.aws_caller_identity.current.account_id
  timestamp       = timestamp()
  timestamp_clean = replace(local.timestamp, "/[- TZ:]/", "")
  bucket_name = "${var.config_name}-bucket-${local.timestamp_clean}"  
}

module "aws_lz_config_create_bucket"{
  source = "./templates/modules/s3-bucket"
  bucket_name = local.bucket_name
  config_logs_prefix = var.config_logs_prefix
  default_tags {
    AccountID   = local.account_id
  }
}

module "aws_lz_config_iam"{
    source = "./templates/modules/config/config-iam"
    config_logs_bucket = local.bucket_name    
    default_tags {
      AccountID = local.account_id
    }
}

module "aws_lz_config_service"{
  source = "./templates/modules/config/config-service"
  role_arn = module.aws_lz_config_iam.arn
  config_logs_bucket = local.bucket_name
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
