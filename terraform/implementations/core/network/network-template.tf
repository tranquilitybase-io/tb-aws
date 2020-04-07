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

  ram_name = "aws_lz_ram_tgw"
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

  azs             = [local.primary_az,local.secondary_az]
  public_subnets  = var.egress_vpc_public_subnets
  private_subnets = var.egress_vpc_private_subnets

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true

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
module "aws_lz_tgw_egress_vpc_route"{
  source  = "./modules/route"
  providers = {
    aws = aws.network-account
  }
  route_table = module.aws_lz_egress_vpc.public_route_table_ids
  destination = var.tgw_vpc_internal_traffic_cidr
  transit_gateway = module.aws_lz_tgw.tgw_id
}
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

  azs             = [local.primary_az,local.secondary_az]
  public_subnets  = var.ingress_vpc_public_subnets
  private_subnets = var.ingress_vpc_private_subnets

  enable_nat_gateway = false
  single_nat_gateway = false
  one_nat_gateway_per_az = false

  private_subnet_tags = {"kubernetes.io/role/internal-elb" = 1}
  public_subnet_tags = {"kubernetes.io/role/elb" = 1}

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id, (var.tag_key_name) = "network", "kubernetes.io/cluster/${var.ingress_eks_cluster_name}" = "shared"}
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

#Security Group
module "nginx_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.4.0"
  
  providers = {
    aws = aws.network-account
  }
  name = var.nginx_security_group_name
  description = var.nginx_security_group_description
  vpc_id = module.aws_lz_ingress_vpc.vpc_id

  ingress_cidr_blocks = var.nginx_ingress_cidr_blocks
  ingress_rules       = var.nginx_ingress_rules
  egress_rules        = var.nginx_egress_rules

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id, (var.tag_key_name) = "network" }
}
#<----

#EC2 Instances
module "ec2_instance_nginx" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.13.0"
  providers = {
    aws = aws.network-account
  }
  name = var.nginx_instance_name
  ami = var.nginx_ami_version
  instance_type = var.nginx_instance_type
  subnet_id = element(tolist(module.aws_lz_ingress_vpc.public_subnets),0)
  vpc_security_group_ids = list(module.nginx_security_group.this_security_group_id)
  user_data = replace(file("../automation/user_data_scripts/ubuntu_nginx.sh"),"internal_server_ip",element(tolist(module.ec2_instance.private_ip),0))
  key_name = var.network_account_key_name

  tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id, (var.tag_key_name) = "network" }
}
#<----

#SECURITY ROLES
 module "aws_lz_iam_security_admin_network" {
   source = "./modules/iam"
 
   providers = {
     aws = aws.network-account
   }

   role_name = "${local.security_role_name}"
   assume_role_policy = "${data.aws_iam_policy_document.aws_lz_assume_role_security.json}"
   role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id }

   #attachment
  role_policy_attach = true
  policy_arn = local.administrator_access_arn
 }

  module "aws_lz_iam_security_audit_network" {
   source = "./modules/iam"
   providers = {
     aws = aws.network-account
   }

   role_name = "${local.security_role_name_audit}"
   assume_role_policy = "${data.aws_iam_policy_document.aws_lz_assume_role_security.json}"
   role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id }
   #attachment
   role_policy_attach = true
   policy_arn = local.read_only_access_arn
  }

### BEGIN VPN Connection modules -->
# Create Customer Gateway
  module "aws_lz_customer_gateway" {
    source = "./modules/vpn/customer-gateway"
    providers = {
      aws = aws.network-account
    }

    cgw_name = format("aws_lz_cgw_%s",local.network_account_id)
    create_cgw = var.create_vpn
    bgn_asn = var.cgw_bgn_asn
    customer_ip_address = var.cgw_ip_address
    cgw_type = var.cgw_type

    tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id, (var.tag_key_name) = "network" }
  }

#Create VPN Connection
  module "aws_lz_vpn_connection" {
    source = "./modules/transit-gateway/tgw-vpn-attachment"
    providers = {
      aws = aws.network-account
    }

    vpn_attach_name = format("aws_lz_vpn_tgw_attachment_%s",local.network_account_id)
    create_vpn_connection = var.create_vpn
    cgw_id = module.aws_lz_customer_gateway.cgw_id
    tgw_id = module.aws_lz_tgw.tgw_id
    cgw_type = module.aws_lz_customer_gateway.cgw_type
    cgw_static_route = var.cgw_static_route

    tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.network_account_id, (var.tag_key_name) = "network" }
  }
### END VPN Connection <--

/*
# Create EKS cluster
  module "ingress_eks_cluster" {
    source = "./modules/eks"
    providers = {
      aws = aws.network-account
    }

    eks_iam_role_name     = var.ingress_eks_role_name
    subnets               = concat(module.aws_lz_ingress_vpc.public_subnets, module.aws_lz_ingress_vpc.private_subnets)
    eks_cluster_name      = var.ingress_eks_cluster_name

    node_group_name       = var.ingress_eks_node_group_name
    node_group_role_name  = var.ingress_eks_node_group_role_name
    node_group_subnets    = module.aws_lz_ingress_vpc.private_subnets # module.aws_lz_ingress_vpc.public_subnets
    #eks_user_policy   = uses the default in module
    
    #eks_cluster_name = "eks_test"
    #eks_role_name = "eks_role_test"

    #tags = { (var.tag_key_project_id) = var.awslz_proj_id }
  }
  */