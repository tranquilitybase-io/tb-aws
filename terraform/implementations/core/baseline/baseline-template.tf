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

module "aws_lz_config_sns_topic_2" {
  source = "./modules/snstopic"

  providers = {
    aws = aws.sandbox-account-2
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
  #account_id         = local.sandbox_account_id
  sns_topic_arn      = module.aws_lz_config_sns_topic.topic_arn
  #account_role_name  = var.org_admin_role
  config_tags        = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox_account_id, (var.tag_key_name) = "config" }
}

module "aws_lz_config_service_2" {
  source = "./modules/config/config-service"

  providers = {
    aws = aws.sandbox-account-2
  }

  config_name        = var.config_name
  config_logs_bucket = module.aws_lz_config_bucket.bucket_name_log
  s3_log_prefix      = module.aws_lz_config_bucket.s3_log_prefix
  #account_id   = local.sandbox2_account_id
  sns_topic_arn      = module.aws_lz_config_sns_topic_2.topic_arn
  #account_role_name  = var.org_admin_role
  config_tags        = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox2_account_id, (var.tag_key_name) = "config" }
}

############################
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
############################################
module "aws_lz_config_rules" {
  source  = "./modules/config/config-rules"

  providers = {
    aws = aws.sandbox-account
  }

  recorder_main    = module.aws_lz_config_service.recorder_name
  delivery_channel = module.aws_lz_config_service.delivery_channel_name
}

module "aws_lz_config_rules_2" {
  source  = "./modules/config/config-rules"

  providers = {
    aws = aws.sandbox-account-2
  }

  recorder_main    = module.aws_lz_config_service_2.recorder_name
  delivery_channel = module.aws_lz_config_service_2.delivery_channel_name
}

### CONFIG SERVICE <--

### CLOUDTRAIL SERVICE -->
### Topic for CloudTrail --->
module "aws_lz_cloudtrail_sns_topic" {
  source = "./modules/snstopic"

  providers = {
    aws = aws.sandbox-account
  }

  sns_topic_name = var.cloudtrail_topic_name
  required_tags  = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox_account_id, (var.tag_key_name) = "cloudtrail" }
}

module "aws_lz_cloudtrail_sns_topic_2" {
  source = "./modules/snstopic"

  providers = {
    aws = aws.sandbox-account-2
  }

  sns_topic_name = var.cloudtrail_topic_name
  required_tags  = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox2_account_id, (var.tag_key_name) = "cloudtrail" }
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

module "aws_lz_cloudtrail_2" {
  source = "./modules/cloudtrail"

  providers = {
    aws = aws.sandbox-account-2
  }

  cloudtrail_name = var.cloudtrail_name
  bucket_name = module.aws_lz_config_bucket.bucket_name_log
  s3_log_prefix = module.aws_lz_config_bucket.s3_log_prefix
  bucket_arn = module.aws_lz_config_bucket.bucket_log_arn
  bucket_account_id = local.sandbox2_account_id
  sns_topic_arn = module.aws_lz_cloudtrail_sns_topic_2.topic_arn
  region = local.region
  required_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox2_account_id, (var.tag_key_name) = "cloudtrail" }
}

### CLOUDTRAIL SERVICE <--

### VPC --->
/*Using terraform VPC module, see https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.29.0 */

module "vpc_sandbox" {
  source  = "terraform-aws-modules/vpc/aws"
  providers = {
    aws = aws.sandbox-account
  }
  name = var.vpc_sandbox_1_name
  cidr = var.vpc_sandbox_1_cidr
  azs             = [local.primary_az,local.secondary_az]
  private_subnets = var.vpc_sandbox_1_private_subnets_cidr
  public_subnets  =  var.vpc_sandbox_1_public_subnets_cidr

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox_account_id, (var.tag_key_name) = "sandbox" }
}

module "vpc_sandbox_2" {
  source  = "terraform-aws-modules/vpc/aws"
  providers = {
    aws = aws.sandbox-account-2
  }
  
  name = var.vpc_sandbox_2_name
  cidr = var.vpc_sandbox_2_cidr
  azs             = [local.primary_az,local.secondary_az]
  private_subnets = var.vpc_sandbox_2_private_subnets_cidr
  public_subnets  = var.vpc_sandbox_2_public_subnets_cidr

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox2_account_id, (var.tag_key_name) = "sandbox" }
}

### VPC-TGW attachment

module "vpc_sandbox_twg_attachment" {
  source  = "./modules/transit-gateway/tgw-vpc-attachment"

  providers = {
    aws = aws.sandbox-account
  }

  attach_name = format("aws_lz_sandbox_vpc_attach_%s",local.sandbox_account_id)
  subnets_ids = module.vpc_sandbox.private_subnets
  vpc_id = module.vpc_sandbox.vpc_id
  transit_gateway_id = module.aws_lz_tgw.tgw_id
  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox_account_id}
} 

module "vpc_sandbox_2_twg_attachment" {
  source  = "./modules/transit-gateway/tgw-vpc-attachment"
  providers = {
    aws = aws.sandbox-account-2
  }

  attach_name = format("aws_lz_sandbox2_vpc_attach_%s",local.sandbox2_account_id)
  subnets_ids =  module.vpc_sandbox_2.private_subnets
  vpc_id = module.vpc_sandbox_2.vpc_id
  transit_gateway_id = module.aws_lz_tgw.tgw_id
  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sandbox_account_id}
}
#<---

#Routes
module "internet_route_sandbox"{
  source  = "./modules/route"
  providers = {
    aws = aws.sandbox-account
  }
  route_table = module.vpc_sandbox.private_route_table_ids
  destination = var.internet_cidr
  transit_gateway = module.aws_lz_tgw.tgw_id
}

module "internal_route_sandbox"{
  source  = "./modules/route"
  providers = {
    aws = aws.sandbox-account
  }
  route_table = module.vpc_sandbox.private_route_table_ids
  destination = var.internal_traffic_cidr
  transit_gateway = module.aws_lz_tgw.tgw_id
}

module "internet_route_sandbox_2"{
  source  = "./modules/route"
  providers = {
    aws = aws.sandbox-account-2
  }
  route_table = module.vpc_sandbox_2.private_route_table_ids
  destination = var.internet_cidr
  transit_gateway = module.aws_lz_tgw.tgw_id
}

module "internal_route_sandbox_2"{
  source  = "./modules/route"
  providers = {
    aws = aws.sandbox-account-2
  }
  route_table = module.vpc_sandbox_2.private_route_table_ids
  destination = var.internal_traffic_cidr
  transit_gateway = module.aws_lz_tgw.tgw_id
}
#<----

#EC2 Instances
module "instances_sandbox_1" {
  source = "./modules/ec2"
  providers = {
    aws = aws.sandbox-account
  }
  ami_version = var.ami_version
  instance_type = var.instance_type
  subnet_id = element([module.vpc_sandbox.private_subnets],0)
}
