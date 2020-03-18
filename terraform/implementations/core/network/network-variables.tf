
variable "vpc_module_version" {
  default = "~> 2.0"
  description = "vpc_module_version"
}


variable "egress_vpc_name" {
  default = "aws_lz_egress_vpc"
  description = "Egress VPC Name"
}

variable "egress_vpc_cidr"{
  description = "Egress VPC CIDR"
  default = "10.99.0.0/22"
}

variable "egress_vpc_public_subnets_cidr"{
  description = "Public subnet CIDR range"
  default = ["10.99.1.0/24", "10.99.2.0/24"]
}

variable "egress_vpc_azs"{
  description = "Availability Zone List"
  default = ["us-west-2a", "us-west-2b"]
}


