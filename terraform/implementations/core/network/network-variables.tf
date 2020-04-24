variable "ingress_vpc_name" {
  default = "aws_lz_ingress_vpc"
  description = "Ingress VPC Name"
}

variable "ingress_vpc_cidr"{
  description = "Egress VPC CIDR"
  default = "10.99.4.0/22"
}

variable "ingress_vpc_public_subnets"{
  description = "Ingress VPC Pubic Subnets list"
  type = list(string)
  default = ["10.99.4.0/24", "10.99.5.0/24"]
}

variable "ingress_vpc_private_subnets"{
  description = "Ingress VPC Private Subnets list"
  type = list(string)
  default = ["10.99.6.0/24", "10.99.7.0/24"]
}

variable "egress_vpc_name" {
  default = "aws_lz_egress_vpc"
  description = "Egress VPC Name"
}

variable "egress_vpc_cidr"{
  description = "Egress VPC CIDR"
  default = "10.99.0.0/22"
}

variable "egress_vpc_public_subnets"{
  description = "Egress VPC Pubic Subnets list"
  type = list(string)
  default = ["10.99.0.0/24", "10.99.1.0/24"]
}

variable "egress_vpc_private_subnets"{
  description = "Egress VPC Private Subnets list"
  type = list(string)
  default = ["10.99.2.0/24", "10.99.3.0/24"]
}

variable "inline_vpc_name" {
  default = "aws_lz_inline_vpc"
  description = "In-line VPC Name"
}

variable "inline_vpc_cidr"{
  description = "In-line VPC CIDR"
  default = "10.99.12.0/22"
}

variable "inline_vpc_public_subnets"{
  description = "In-line VPC Pubic Subnets list"
  type = list(string)
  default = []
}

variable "inline_vpc_private_subnets"{
  description = "In-line VPC Private Subnets list"
  type = list(string)
  default = ["10.99.12.0/24", "10.99.13.0/24"]
}

variable "tgw_vpc_internet_cidr"{
  default = "0.0.0.0/0"
}

variable "tgw_vpc_internal_traffic_cidr"{
  default = "10.0.0.0/8"
}

# Instances variables
variable "network_reverse_proxy_instance_name" {
  description = "Nginx instance name"
  default = "awslz_reverse_proxy"
}

variable "network_reverse_proxy_private_ip" {
  description = "Private ip for the Sandbox web server"
  type        = string
  default     = "10.99.4.100"
}

variable "ubuntu18_04_ami_version" {
  description = "AMI version to deploy Ubuntu 18.04"
  default = "ami-0d1cd67c26f5fca19"
}

variable "t2_micro_instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}

variable "nginx_user_data" {
  description = "User data for the instance"
  default = ""
}

variable "network_account_key_name" {
  description = "Key pair name of the Network Account"
  default = "Deployer-key-2" #"linux-servers-network-aac"
}

variable "bastion_instance_name" {
  description = "Bastion instance name"
  default = "awslz_bastion-01"
}

variable "bastion_ami_version" {
  description = "AMI version to deploy bastion"
  default = "ami-0d6621c01e8c2de2c"
}

# Security Groups variables
# Reverse proxy
variable "network_reverse_proxy_security_group_name" {
  description = "Security group name"
  default = "reverse_proxy_internet"
}

variable "network_reverse_proxy_security_group_description" {
  description = "Security group description"
  default = "Reverse proxy server: http and https"
}

variable "network_reverse_proxy_ingress_rules" {
  description = "Ingress rules"
  default = ["https-443-tcp","http-80-tcp","http-8080-tcp"]
}

# Bastion access to internal network
variable "network_bastion_internal_access_security_group_name" {
  description = "Bastion security group name to access internal network"
  default = "awslz_bastion_access_to_internal"
}

variable "network_bastion_internal_access_security_group_description" {
  description = "Bastion Security group description"
  default = "Bastion access to internal network"
}

variable "network_bastion_internal_access_ingress_rules" {
  description = "Bastion ingress rules"
  default = ["ssh-tcp","all-icmp"]
}

# Bastion access from Internet
variable "bastion_security_group_name" {
  description = "Bastion security group name"
  default = "awslz_bastion_access_from_internet"
}

variable "bastion_security_group_description" {
  description = "Bastion Security group description"
  default = "Bastion server: ssh and icmp"
}

variable "bastion_ingress_rules" {
  description = "Bastion ingress rules"
  default = ["ssh-tcp"]
}

variable "internet_ingress_cidr_blocks" {
  description = "Ingress cidr block"
  default = ["0.0.0.0/0"]
}

variable "all_all_egress_rules" {
  description = "Egress rules"
  default = ["all-all"]
}

# VPN variables
variable "create_vpn" {
  description = "Boolean to decide if the VPN is created or not"
  type = bool
  default = false
}

variable "cgw_bgn_asn" {
  description = "BGN ASN number"
  type = number
  default = 64998
}

variable "cgw_ip_address" {
  description = "Customer IP address"
  default = "34.82.155.58"
}

variable "cgw_type" {
  description = "Type of customer gateway"
  default = "ipsec.1"
}

variable "cgw_static_route" {
  description = "Static Route ?"
  type = bool
  default = false
}

# Ingress EKS cluster variables
variable "ingress_eks_cluster_name" {
  description = "Ingress VPC EKS cluster name"
  default = "awslz_eks_ingress_cluster"
}

variable "ingress_eks_role_name" {
  description = "EKS role name"
  default = "awslz_eks_ingress_cluster"
}

variable "ingress_subnets_list" {
  description = "Subnets for the EKS cluster"
  default     = ""
}

variable "ingress_eks_node_group_name" {
  description = "Name of the node group for the cluster"
  default     = "awslz_eks_node_group_ingress_cluster"
}

variable "ingress_eks_node_group_role_name" {
  description = "Ingress Cluster node group name"
  default     = "awslz_eks_ingress_node_group"
}

variable "ingress_eks_node_group_instance_types" {
  description = "Instances types for the node group"
  default     = ["t3.small"]
}

# Key pair variables
variable "deployment_key_name" {
  description = "Deployment key name"
  default     = "Deployer-key-2"
}

# Environment variables
# ssh-keygen
variable "env_deployment_key" {
  description = "Environment key"
  default = ""
}

# date from environment
variable "env_generation_date" {
  description = "Key pair generation date"
  default = ""
}

variable "netmon_instance_name" {
  description = "Network Monitoring instance name"
  default = "aws_lz_nagios_netmon"
}

variable "amzn2_ami_version" {
  description = "AMI version to deploy Amazon Linux 2"
  default = "ami-0d6621c01e8c2de2c"
}

variable "netmon_security_group_name" {
  description = "Security group name"
  default = "aws_lz_netmon_sg"
}

variable "netmon_security_group_description" {
  description = "Security group description"
  default = "Internal server: http, https, ssh"
}

variable "netmon_ingress_rules" {
  description = "Ingress rules"
  type = list(string)
  default = ["https-443-tcp","http-80-tcp","ssh-tcp"]
}

variable "email_netmon" {
  description = "Email account for networking events notification"
  default = "cesar.sanchez@gft.com"
}

variable "netmon_private_ip" {
  description = "Private ip for the Sandbox web server"
  type        = string
  default     = "10.99.12.100"
}