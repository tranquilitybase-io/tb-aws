variable "eks_cluster_name" {
  description = "EKS name"
  type = string
}

variable "eks_role_arn" {
  description = "EKS role ARN"
  type = string
}

#variable "eks_vpc_subnet_list" {
#  description = "List of subnets in the VPC to be used by EKS"
#  type = list(string)
#}

variable "eks_role_name" {
  type = string
  description = "EKS role name"
}
 
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

