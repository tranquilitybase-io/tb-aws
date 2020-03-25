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

variable "vpc_azs"{
    description = "Availability zones where the VPC will span"
    default = ["us-west-2a","us-west-2b"]
}

variable "enable_nat_gateway"{
    description = "Enable NAT gateway"
    default = false
}

variable "enable_vpn_gateway"{
    description = "Enable VPN gateway"
    default = false
}

variable "internet_cidr"{
    default = "0.0.0.0/0"
}

variable "internal_traffic_cidr"{
    default = "10.0.0.0/8"
}