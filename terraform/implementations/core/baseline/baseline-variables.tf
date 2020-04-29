variable "create_sandbox1_attachment" {
  description = "Flag to create Sandbox1 VPC Attachment"
  default = false
}

variable "create_sandbox2_attachment" {
  description = "Flag to create Sandbox2 VPC Attachment"
  default = false
}

variable "config_name" {  
    default = "aws_lz_config"
    description = "Config Service name"
}

variable "cloudtrail_name" {
  default = "aws_lz_cloudtrail"
  description = "Config Service name"
}

variable "config_topic_name" {
  default = "aws_lz_config_sns_topic"
  description = "Name of topic for Config service"
}

variable "cloudtrail_topic_name" {
  default = "aws_lz_cloudtrail_alarm_sns_topic"
  description = "Name of topic for CloudTrail service"
}

variable "vpc_sandbox_1_cidr"{
    description = "Sandbox account 1 VPC CIDR range"
    default = "10.100.0.0/22"    
}

variable "vpc_sandbox_1_name"{
    description = "Sandbox account 1 VPC name"
    default = "AWS_LZ_VPC_Sandbox"    
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
variable "vpc_sandbox_2_name"{
    description = "Sandbox account 2 VPC name"
    default = "AWS_LZ_VPC_Sandbox_2"    
}

variable "vpc_sandbox_2_private_subnets_cidr"{
    description = "Sandbox account 2 VPC private subnet CIDR range"
    default = ["10.101.1.0/24", "10.101.2.0/24"]
}

variable "vpc_sandbox_2_public_subnets_cidr"{
    description = "Sandbox account 2 VPC public subnet CIDR range"
    default = []
}

variable "enable_nat_gateway"{
    description = "Enable NAT gateway"
    default = false
}

variable "internet_cidr"{
    default = "0.0.0.0/0"
}

variable "internal_traffic_cidr"{
    default = "10.0.0.0/8"
}

# Instances variables
variable "sandbox_web_server_instance_name" {
  description = "Instance name"
  default = "awslz_test_web_server"
}

variable "sandbox_web_server_private_ip" {
  description = "Private ip for the Sandbox web server"
  type        = string
  default     = "10.100.1.100"
}

# Key pair variables
variable "sandbox_deployment_key_name" {
  description = "Deployment key name"
  default     = "Deployer-key"
}

variable "user_data" {
  description = "User data for the instance"
  default = "apt-get update; apt-get install apache2; systemctl start apache2.service; systemctl enable apache2"
}


variable "security_group_name" {
  description = "Security group name"
  default = "internal_webserver"
}

variable "security_group_description" {
  description = "Security group description"
  default = "Internal server: http, ssh and icmp"
}

variable "cidr_blocks" {
  description = "Ingress cidr block"
  default = ["10.0.0.0/8"]
}

variable "web_internal_ingress_rules" {
  description = "Ingress rules"
  default = ["https-443-tcp","http-80-tcp","ssh-tcp"]
}

variable "web_internal_egress_rules" {
  description = "Egress rules"
  default = ["all-all"]
}

variable "sandbox_2_account_key_name" {
  description = "Key pair name of the Sandbox 2 Account"
  default = "aws-lz"
}