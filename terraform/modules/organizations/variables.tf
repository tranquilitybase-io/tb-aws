
variable "aws_organizations_service_access_principals" {
    type = list(string)
    default = ["cloudtrail.amazonaws.com","config.amazonaws.com","ram.amazonaws.com"]
    description = "AWS Organizations Service Access Principals"
}

variable "aws_organizations_enable_policy_types" {
    type = list(string)
    default = ["SERVICE_CONTROL_POLICY","TAG_POLICY"]
    description = "AWS Organizations Enable Policy Types"
}

variable "aws_organizations_feature_set" {
    type = string
    default = "ALL"
    description = "AWS Organizations Feature Set"
}

variable "create_lz_organization" {
    description = "Create AWS Organizations?"
    type = bool
    default = false
}

variable "org_account_name" {
    description = "AWS Organizations Account Name"
    type = string
    default = ""
}

variable "org_account_email" {
    description = "AWS Organizations Account Email"
    type = string
    default = ""
}

variable "org_tags" {
    description = "Required tags"
    default = {}
}

variable "ou_name" {
    description = "Organization Unit Name"
    type = string
    default = ""
}

variable "ou_parent_id" {
    description = "Organization parent ID"
    type = string
    default = ""
}

variable "account_parent_id" {
    description = "Account parent ID"
    type = string
    default = ""
}

variable "policy_id" {
    description = "Policy ID"
    type = string
    default = ""
}

variable "policy_name" {
    description = "Policy Name"
    type = string
    default = ""
}

variable "policy_description" {
    description = "Policy Description"
    type = string
    default = ""
}

variable "policy_type" {
    description = "Policy Type"
    type = string
    default = ""
}

variable "policy_content" {
    description = "Policy Content"
    type = string
    default = ""
}

variable "target_id" {
    description = "Target ID"
    default = []
}

variable "account_role_name" {
    description = "Account Role Names"
    type= string
    default = ""
}