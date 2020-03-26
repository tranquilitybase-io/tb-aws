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