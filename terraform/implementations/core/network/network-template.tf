
module "tgw" {
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


module "vpc-network-account" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  providers = {
    aws = aws.network-account
  }

  name = var.egress_vpc_name

  cidr = "10.99.0.0/22"

  azs             = ["us-west-2a", "us-west-2b"]
  public_subnets  = ["10.99.1.0/24", "10.99.2.0/24"]
}
