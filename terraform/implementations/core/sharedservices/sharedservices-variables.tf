# VPC 
variable "vpc_sharedservices_cidr"{
    description = "Shared Services VPC CIDR range"
    default = "10.99.8.0/22"
}

variable "vpc_sharedservices_name"{
    description = "Shared Services VPC name"
    default = "AWS_LZ_VPC_SharedServices"    
}

variable "vpc_sharedservices_private_subnets_cidr"{
    description = "Shared Services VPC private subnet CIDR range"
    default = ["10.99.8.0/24","10.99.9.0/24"]
}
variable "vpc_sharedservices_public_subnets_cidr"{
    description = "Shared services VPC public subnet CIDR range"
    default = []
}

variable "enable_nat_gateway_sharedservices"{
    description = "Enable NAT gateway"
    default = false
}

variable "enable_vpn_gateway_sharedservices"{
    description = "Enable VPN gateway"
    default = false
}

variable "internet_cidr_sharedservices"{
    default = "0.0.0.0/0"
}

variable "internal_traffic_cidr_sharedservices"{
    default = "10.0.0.0/8"
}

# Key pair variables
variable "shared_services_deployment_key_name" {
  description = "Shared Services deployment key name"
  default     = "Deployer-key"
}

# Security Groups variables
# Linux kubectl
variable "kubectl_security_group_name" {
  description = "Linux kubectl security group name"
  default = "kubectl_server"
}

variable "kubectl_security_group_description" {
  description = "Linux kubectl security group description"
  default = "Internal server: kubectl controller"
}

variable "kubectl_ingress_rules" {
  description = "Linux kubectl ingress rules"
  default = ["ssh-tcp"]
}

variable "internal_ingress_cidr_blocks" {
  description = "Internal ingress cidr block"
  default = ["10.0.0.0/8"]
}

# Instances variables
variable "kubectl_instance_name" {
  description = "Linux kubectl instance name"
  default = "awslz_kubectl_server-1"
}