variable "vpc_sandbox_1_cidr"{
    description = "Sandbox account 1 VPC CIDR range"
    default = "10.100.0.0/22"    
}

variable "vpc_sandbox_1_private_subnets_cidr"{
    description = "Sandbox account 1 VPC private subnet CIDR range"
    default = ["10.100.1.0/24","10.100.2.0/24"]
}
variable "vpc_sandbox_1_public_subnets_cidr"{
    description = "Sandbox account 1 VPC public subnet CIDR range"
    default = []
}

variable "vpc_sandbox_2_cidr"{
    description = "Sandbox account 2 VPC CIDR range"
    default = "10.101.0.0/22"
}
variable "vpc_sandbox_2_private_subnets_cidr"{
    description = "Sandbox account 2 VPC private subnet CIDR range"
    default = ["10.101.1.0/24", "10.101.2.0/24"]
}

variable "vpc_sandbox_2_public_subnets_cidr"{
    description = "Sandbox account 2 VPC public subnet CIDR range"
    default = []
}

variables "vpc_azs"{
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