### VPC --->
/*Using terraform VPC module, see https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.29.0 */

module "vpc_shared_services" {
  source  = "terraform-aws-modules/vpc/aws"
  providers = {
    aws = aws.sharedservices-account
  }
  name = var.vpc_sharedservices_name
  cidr = var.vpc_sharedservices_cidr
  azs             = var.vpc_azs_sharedservices
  private_subnets = var.vpc_sharedservices_private_subnets_cidr
  public_subnets  =  var.vpc_sharedservices_public_subnets_cidr

  enable_nat_gateway = var.enable_nat_gateway_sharedservices
  enable_vpn_gateway = var.enable_vpn_gateway_sharedservices

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sharedservices_account_id, (var.tag_key_name) = "sharedservices" }
}

module "vpc_sharedservices_twg_attachment" {
  source  = "./modules/transit-gateway/tgw-vpc-attachment"

  providers = {
    aws = aws.sharedservices-account
  }

  attach_name = format("aws_lz_sharedservices_vpc_attach_%s",local.sharedservices_account_id)
  subnets_ids = module.vpc_shared_services.private_subnets
  vpc_id = module.vpc_shared_services.vpc_id
  transit_gateway_id = module.aws_lz_tgw.tgw_id
  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sharedservices_account_id}
} 

module "internet_route_sharedservices"{
  source  = "./modules/route"
  providers = {
    aws = aws.sharedservices-account
  }
  route_table = module.vpc_shared_services.private_route_table_ids
  destination = var.internet_cidr_sharedservices
  transit_gateway = module.aws_lz_tgw.tgw_id
}

module "internal_route_sharedservices"{
  source  = "./modules/route"
  providers = {
    aws = aws.sharedservices-account
  }
  route_table = module.vpc_shared_services.private_route_table_ids
  destination = var.internal_traffic_cidr_sharedservices
  transit_gateway = module.aws_lz_tgw.tgw_id
}