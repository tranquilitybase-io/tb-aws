variable "aws_organizations_account_tags" {
    type = list(string)
    default = ["config.amazonaws.com"]
}

variable "aws_organizations_service_access_principals" {
    type = list(string)
    default = ["cloudtrail.amazonaws.com","config.amazonaws.com"," ram.amazonaws.com"]
}

variable "aws_organizations_enable_policy_types" {
    type = list(string)
    default = ["SERVICE_CONTROL_POLICY","TAG_POLICY"]
}

variable "aws_organizations_feature_set" {
    type = string
    default = "ALL"
}

variable "create_lz_organization" {
    type = bool
    default = false
}

variable "org_account_name" {
    type = string
    default = ""
}

variable "org_account_email" {
    type = string
    default = ""
}

variable "org_tags" {
  default = {} 
}

variable "ou_name" {
    type = string
    default = ""
}

variable "ou_parent_id" {
    type = string
    default = ""
}

variable "account_parent_id" {
    type = string
    default = ""
}

variable "policy_name" {
    type = string
    default = ""
}

variable "policy_description" {
    type = string
    default = ""
}

variable "policy_type" {
    type = string
    default = ""
}

variable "policy_content" {
    type = string
    default = ""
}

variable "target_id" {
    default = []
}

variable "policy_id" {
    type = string
    default = ""
}

variable "org_accounts"{
    type = list
    default = []
}
variable "account_role_name" {
    type= string
    default = ""
}