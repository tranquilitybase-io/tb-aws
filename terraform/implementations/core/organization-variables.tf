variable "aws_organizations_account_sharedservices_name" {
    description = "Shared Services name"
    default ="sharedservice"
}
variable "aws_organizations_account_sharedservices_email" {
    description = "Shared Services email"
    default = "sharedservice_email"
}

variable "aws_organizations_account_logarchive_name" {
    description = "Log Archive accounts name"
    default = "logarchive"
}

variable "aws_organizations_account_logarchive_email" {
    description = "Log Archive accounts email"
    default = "logarchive_email"
}

variable "aws_organizations_account_security_name" {
    description = "Security accounts name"
    default = "security"
}
variable "aws_organizations_account_security_email" {
    description = "Security accounts email"
    default = "security_email"
}
variable "aws_organizations_account_network_name" {
    description = "Network accounts name"
    default = "network"
}
variable "aws_organizations_account_network_email" {
    description = "Network accounts email"
    default = "network_email"
}

variable "aws_organizations_account_sandboxdev_name" {
    description = "Sandbox DEV accounts name"
    default = "test-account"
}
variable "aws_organizations_account_sandboxdev_email" {
    description = "Sandbox DEV accounts email"
    default = "test-account_email"
}
variable "aws_organizations_account_sandboxprod_name" {
    description = "Sandbox PROD accounts name"
    default = "test-account-2"
}
variable "aws_organizations_account_sandboxprod_email" {
    description = "Sandbox PROD accounts email"
    default = "test-account-2_email"
}