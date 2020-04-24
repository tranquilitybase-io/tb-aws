### VPC --->
/*Using terraform VPC module, see https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.29.0 */

module "vpc_shared_services" {
  source  = "terraform-aws-modules/vpc/aws"
  providers = {
    aws = aws.sharedservices-account
  }
  name = var.vpc_sharedservices_name
  cidr = var.vpc_sharedservices_cidr
  azs             = [local.primary_az,local.secondary_az]
  private_subnets = var.vpc_sharedservices_private_subnets_cidr
  public_subnets  =  var.vpc_sharedservices_public_subnets_cidr

  enable_nat_gateway = var.enable_nat_gateway_sharedservices
  enable_vpn_gateway = var.enable_vpn_gateway_sharedservices

  # Required tags for EKS
  private_subnet_tags = {"kubernetes.io/role/internal-elb" = 1}

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sharedservices_account_id, (var.tag_key_name) = "sharedservices", "kubernetes.io/cluster/${var.ec_eks_cluster_name}" = "shared"}
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

#SECURITY ROLES
 module "aws_lz_iam_security_admin_sharedservices" {
   source = "./modules/iam"
 
   providers = {
     aws = aws.sharedservices-account
   }

   role_name = "${local.security_role_name}"
   assume_role_policy = "${data.aws_iam_policy_document.aws_lz_assume_role_security.json}"
   role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sharedservices_account_id }

   #attachment
  role_policy_attach = true
  policy_arn = local.administrator_access_arn
 }

  module "aws_lz_iam_security_audit_sharedservices" {
   source = "./modules/iam"
   providers = {
     aws = aws.sharedservices-account
   }

   role_name = "${local.security_role_name_audit}"
   assume_role_policy = "${data.aws_iam_policy_document.aws_lz_assume_role_security.json}"
   role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sharedservices_account_id }
   #attachment
   role_policy_attach = true
   policy_arn = local.read_only_access_arn
  }

/*
# EKS cluster
module "aws_lz_eks_eagleconsole_cluster" {
  source = "./modules/eks"
  providers = {
    aws = aws.sharedservices-account
  }

  eks_cluster_name          = var.ec_eks_cluster_name
  eks_iam_role_name         = var.ec_eks_role_name
  subnets                   = module.vpc_shared_services.private_subnets
#  eks_user_policy           = data.aws_iam_policy_document.aws_lz_eks_cluster_sharedservices.json

  node_group_name           = var.ec_eks_node_group_name
  node_group_role_name      = var.ec_eks_node_group_role_name
  node_group_subnets        = module.vpc_shared_services.private_subnets
  node_group_instance_types = var.ec_eks_node_group_instance_types
}
# END EKS cluster
*/

# Key pair
module "sharedservices_account_keypair" {
  source = "./modules/key-pairs"
  providers = {
    aws = aws.sharedservices-account
  }

  key_name    = var.shared_services_deployment_key_name
  public_key  = var.env_deployment_key
  tags        = { generation_date = var.env_generation_date } 
}
# END Key pair

#Security Group
# Linux kubectl
module "kubectl_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.4.0"
  
  providers = {
    aws = aws.sharedservices-account
  }
  name = var.kubectl_security_group_name
  description = var.kubectl_security_group_description
  vpc_id = module.vpc_shared_services.vpc_id

  ingress_cidr_blocks = var.internal_ingress_cidr_blocks
  ingress_rules       = var.kubectl_ingress_rules
  egress_rules        = var.all_all_egress_rules

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.sharedservices_account_id }
}
#END Security Groups


#EC2 Instances
# kubectl controller
module "ec2_instance_kubectl" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.13.0"
  providers = {
    aws = aws.sharedservices-account
  }
  name = var.kubectl_instance_name
  ami = var.ubuntu18_04_ami_version
  instance_type = var.t2_micro_instance_type
  subnet_id = element(tolist(module.vpc_shared_services.private_subnets),0)
  vpc_security_group_ids = list(module.kubectl_security_group.this_security_group_id)
  #user_data = replace(file("../automation/user_data_scripts/ubuntu_nginx.sh"),"internal_server_ip",element(tolist(module.ec2_instance.private_ip),0))
  key_name = module.sharedservices_account_keypair.key_name #var.network_account_key_name
  disable_api_termination = true
  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id }
}
# END EC2 Instances