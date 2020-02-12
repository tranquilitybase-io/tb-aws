variable "aws_organizations_account_organization_name" {
    description = "Organization accounts details"
    default = "org"
}
variable "aws_organizations_account_organization_email" {
    description = "Organization accounts email"
    default = "org@nn.com"
}
variable "aws_organizations_account_sharedservices_name" {
    description = "Shared Services details"
    default ="sharedservice"
}
variable "aws_organizations_account_sharedservices_email" {
    description = "Shared Services details"
    default = "sharedservice@nn.com"
}
variable "aws_organizations_account_logarchive_name" {
    description = "Log Archive accounts details"
    default = "logarchive"
}
variable "aws_organizations_account_logarchive_email" {
    description = "Log Archive accounts details"
    default = "logarchive@nn.com"
}
variable "aws_organizations_account_security_name" {
    description = "Security accounts details"
    default = "security"
}
variable "aws_organizations_account_security_email" {
    description = "Security accounts details"
    default = "security@nn.com"
}
variable "aws_organizations_account_tags" {
    type = list(string)
    default = ["config.amazonaws.com"]
}

variable "aws_organizations_service_access_principals" {
    type = list(string)
    default = ["cloudtrail.amazonaws.com","config.amazonaws.com"]
}
