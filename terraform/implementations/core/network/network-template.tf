
#Create TGW
module "aws_lz_tgw" {
  source = "./modules/transit-gateway/tgw-main"

  providers = {
    aws = aws.network-account
  }

  name            = format("aws_lz_tgw_%s",local.network_account_id)
  description     = "AWS Landing Zone TGW shared with several other AWS accounts"
  amazon_side_asn = 64599

  enable_auto_accept_shared_attachments = true
  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id, (var.tag_key_name) = "network" }
}

module "aws_lz_aws_ram_share_tg" {
  source = "./modules/ram"

  ram_name = "AWS_LZ_TG"
  ram_allow_external_principals = false
  ram_resource_arn = module.aws_lz_tgw.tgw_arn
  ram_principals =  module.aws_lz_organization_main.org_arn
  ram_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "aws-ram-tg" }

  providers = {
    aws = aws.network-account
  }
}

### </ Egress VPC
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
  #enable_vpn_gateway = true

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id, (var.tag_key_name) = "network" }
}

module "aws_lz_egress_vpc_twg_attachment" {
  source  = "./modules/transit-gateway/tgw-vpc-attachment"

  providers = {
    aws = aws.network-account
  }

  attach_name = format("aws_lz_egress_vpc_attach_%s",local.network_account_id)
  transit_gateway_id = module.aws_lz_tgw.tgw_id
  vpc_id = module.aws_lz_egress_vpc.vpc_id
  subnets_ids =  module.aws_lz_egress_vpc.private_subnets
  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id, (var.tag_key_name) = "network" }
}

module "aws_lz_tgw_route" {
  source = "./modules/transit-gateway/tgw-route-table"

  providers = {
    aws = aws.network-account
  }

  destination_cidr_block = "0.0.0.0/0"
  tgw_id = module.aws_lz_tgw.tgw_id
  attach_id = module.aws_lz_egress_vpc_twg_attachment.tgw_attach_id
}

##Routes
/*module "aws_lz_tgw_egress_vpc_route"{
  source  = "./modules/route"
  providers = {
    aws = aws.network-account
  }
  route_table = module.aws_lz_egress_vpc.public_route_table_ids
  destination = var.tgw_vpc_internal_traffic_cidr
  transit_gateway = module.aws_lz_tgw.tgw_id
}*/
### Egress VPC />

### </ Ingress VPC
module "aws_lz_ingress_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  providers = {
    aws = aws.network-account
  }

  name = var.ingress_vpc_name

  cidr = var.ingress_vpc_cidr

  azs             = ["us-west-2a", "us-west-2b"]
  public_subnets  = ["10.99.4.0/24", "10.99.5.0/24"]
  private_subnets = ["10.99.6.0/24", "10.99.7.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = false
  one_nat_gateway_per_az = false
  #enable_vpn_gateway = true

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id, (var.tag_key_name) = "network" }
}

module "aws_lz_ingress_vpc_twg_attachment" {
  source  = "./modules/transit-gateway/tgw-vpc-attachment"

  providers = {
    aws = aws.network-account
  }

  attach_name = format("aws_lz_ingress_vpc_attach_%s",local.network_account_id)
  transit_gateway_id = module.aws_lz_tgw.tgw_id
  vpc_id = module.aws_lz_ingress_vpc.vpc_id
  subnets_ids =  module.aws_lz_ingress_vpc.private_subnets
  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id, (var.tag_key_name) = "network" }
}

##Routes
module "aws_lz_tgw_internet_ingress_vpc_route"{
  source  = "./modules/route"
  providers = {
    aws = aws.network-account
  }
  route_table = module.aws_lz_ingress_vpc.private_route_table_ids
  destination = var.tgw_vpc_internet_cidr
  transit_gateway = module.aws_lz_tgw.tgw_id
}

module "aws_lz_tgw_ingress_vpc_route"{
  source  = "./modules/route"
  providers = {
    aws = aws.network-account
  }
  route_table = module.aws_lz_ingress_vpc.private_route_table_ids
  destination = var.tgw_vpc_internal_traffic_cidr
  transit_gateway = module.aws_lz_tgw.tgw_id
}
### Ingress VPC />


