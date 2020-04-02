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

variable "tgw_vpc_internet_cidr"{
  default = "0.0.0.0/0"
}

variable "tgw_vpc_internal_traffic_cidr"{
  default = "10.0.0.0/8"
}

# Instances variables
variable "nginx_instance_name" {
  description = "Instance name"
  default = "awslz_nginx"
}

variable "nginx_ami_version" {
  description = "AMI version to deploy"
  default = "ami-0d1cd67c26f5fca19"
}

variable "nginx_instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}

variable "nginx_user_data" {
  description = "User data for the instance"
  default = ""
}

# Security Groups variables
variable "nginx_security_group_name" {
  description = "Security group name"
  default = "external_webserver"
}

variable "nginx_security_group_description" {
  description = "Security group description"
  default = "Internal server: http, ssh and icmp"
}

variable "nginx_ingress_cidr_blocks" {
  description = "Ingress cidr block"
  default = ["0.0.0.0/0"]
}

variable "nginx_ingress_rules" {
  description = "Ingress rules"
  default = ["https-443-tcp","http-80-tcp","ssh-tcp"]
}

variable "nginx_egress_rules" {
  description = "Egress rules"
  default = ["all-all"]
}

variable "network_account_key_name" {
  description = "Key pair name of the Network Account"
  default = "linux-servers-network-aac"
}
