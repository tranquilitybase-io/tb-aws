/*Using terraform VPC module, see https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.29.0 */
module "vpc-sandbox" {
  source  = "terraform-aws-modules/vpc/aws"
  providers = {
    aws = aws.sandbox-account
  }
  name = var.vpc_sandbox_1_name
  cidr = var.vpc_sandbox_1_cidr
  azs             = var.vpc_azs
  private_subnets = var.vpc_sandbox_1_private_subnets_cidr
  public_subnets  =  var.vpc_sandbox_1_public_subnets_cidr

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.current_account_id, (var.tag_key_name) = "sandbox" }
}

module "vpc-sandbox-2" {
  source  = "terraform-aws-modules/vpc/aws"
  providers = {
    aws = aws.sandbox-account-2
  }
  
  name = var.vpc_sandbox_2_name
  cidr = var.vpc_sandbox_2_cidr
  azs             = var.vpc_azs
  private_subnets = var.vpc_sandbox_2_private_subnets_cidr
  public_subnets  = var.vpc_sandbox_2_public_subnets_cidr

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.current_account_id, (var.tag_key_name) = "sandbox" }
}


module "vpc-sandbox-twg-attachment" {
  source  = "./modules/transit-gateway-vpc-attachment"
  providers = {
    aws = aws.sandbox-account
  }
  subnets_ids = module.vpc-sandbox.private_subnets
  vpc_id = module.vpc-sandbox.vpc_id
  transit_gateway_id = module.aws_lz_tgw.tgw_id
}
/*
module "vpc-sandbox-2-twg-attachment" {
  source  = "./modules/transit-gateway-vpc-attachment"
  providers = {
    aws = aws.sandbox-account-2
  }
  subnets_ids = "${list("${module.vpc-sandbox-2.public_subnets}")}"
  vpc_id = module.vpc-sandbox-2.vpc_id
  transit_gateway_id = module.aws_lz_tgw.tgw_id
}*/