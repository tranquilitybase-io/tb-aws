data "aws_caller_identity" "current" {}

locals {
  timestamp       = timestamp()
  timestamp_clean = replace(local.timestamp, "/[- TZ:]/", "")
  bucket_name = "${data.aws_caller_identity.current.account_id}-${local.timestamp_clean}-aws-config-bucket"
  account_id = data.aws_caller_identity.current.account_id
}

module "create_bucket"{
  source = "./templates/modules/s3-bucket"
  bucket_name = local.bucket_name
}

module "config-iam"{
    source = "./templates/modules/config-iam"
    config_logs_bucket = local.bucket_name
    account_id = local.account_id
}

module "config-service"{
    source = "./templates/modules/config-service"
    role_arn = module.config-iam.arn
    config_logs_bucket = local.bucket_name
}

module "config-aggregator"{
    source = "./templates/modules/config-aggregator"
    account_id = local.account_id
}

module "config-rules"{
    source = "./templates/modules/config-rules"
    recorder_main = module.config-service.recorder_main
    delivery_channel = module.config-service.delivery_channel
}
