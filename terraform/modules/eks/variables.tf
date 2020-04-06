variable "eks_iam_role_name" {
  description = "Role name for cluster administration"
  default     = ""
}

variable "eks_cluster_name" {
  description = "EKS name"
  type = string
}

variable "node_group_name" {
  description = "Node group name"
  default     = ""
}


#variable "eks_role_arn" {
#  description = "EKS role ARN"
#  type = string
#}

#variable "eks_vpc_subnet_list" {
#  description = "List of subnets in the VPC to be used by EKS"
#  type = list(string)
#}

#variable "eks_role_name" {
#  type = string
#  description = "EKS role name"
#}
 
variable "eks_user_policy" {
  type = string
  description = "Defaul policy applied to EKS user"
  default = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

variable "node_group_role_policy" {
  type        = string
  description = "Default policy applied to the node group role"
  default     = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


variable "subnets" {
  description = "List of subnets"
  type        = list(string)
}

variable "node_group_subnets" {
  description = "List subnets for node group"
  type        = list(string)
}


variable "node_group_role_name" {
  description = "Node group role name"
  default     = ""
}
