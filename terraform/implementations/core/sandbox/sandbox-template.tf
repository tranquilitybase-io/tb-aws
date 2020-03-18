/*Using terraform VPC module, see https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.29.0*/
module "vpc" {
  providers = {
    aws = aws.sandbox-account
  }
  source  = "terraform-aws-modules/vpc/aws"
  

  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a"]
  private_subnets = ["10.0.101.0/24"]
  public_subnets  = []

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.current_account_id, (var.tag_key_name) = "sandbox" }
}