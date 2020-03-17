variable "vpcname"{
    description = "VPC name"
    default = "VPC-${module.aws_lz_account_sandbox.account_id}"
}