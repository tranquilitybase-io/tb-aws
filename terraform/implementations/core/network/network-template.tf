
module "aws_lz_tgw" {
  source = "./modules/transit-gateway"

  providers = {
    aws = aws.network-account
  }

  name            = "aws_lz_tgw"
  description     = "AWS Landing Zone TGW shared with several other AWS accounts"
  amazon_side_asn = 64599

  enable_auto_accept_shared_attachments = true

  ram_allow_external_principals = true
  ram_principals                = [local.sandbox_account_id,local.sandbox2_account_id]
  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id, (var.tag_key_name) = "network" }
}

module "aws_lz_egress_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  providers = {
    aws = aws.network-account
  }

  name = var.egress_vpc_name

  cidr = var.egress_vpc_cidr

  azs             = ["us-west-2a", "us-west-2b"]
  public_subnets  = ["10.99.0.0/24", "10.99.1.0/24"]
  private_subnets = ["10.99.2.0/24", "10.99.3.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true
  enable_vpn_gateway = true

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id, (var.tag_key_name) = "network" }
}


module "aws_lz_aws_ram_share_tg" {
  source = "./modules/ram"

  ram_name = "AWS_LZ_TG"
  ram_resource_arn = module.aws_lz_tgw.tgw_arn
  ram_principals = module.aws_lz_organization_main.org_arn
  ram_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "aws-ram-tg" }

  providers = {
    aws = aws.network-account
  }
}