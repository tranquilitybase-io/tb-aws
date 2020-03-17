variable "aws_organizations_account_sharedservices_name" {
    description = "Shared Services name"
    default ="sharedservice"
}
variable "aws_organizations_account_sharedservices_email" {
    description = "Shared Services email"
    default = "tl93372@gmail.com"
}

variable "aws_organizations_account_logarchive_name" {
    description = "Log Archive accounts name"
    default = "logarchive"
}

variable "aws_organizations_account_logarchive_email" {
    description = "Log Archive accounts email"
    default = "tl93373@gmail.com"
}

variable "aws_organizations_account_security_name" {
    description = "Security accounts name"
    default = "security"
}
variable "aws_organizations_account_security_email" {
    description = "Security accounts email"
    default = "test.gft.aws.03@gmail.com"
}
variable "aws_organizations_account_network_name" {
    description = "Network accounts name"
    default = "network"
}
variable "aws_organizations_account_network_email" {
    description = "Network accounts email"
    default = "test.gft.aws.04@gmail.com"
}

variable "aws_organizations_account_sandboxdev_name" {
    description = "Sandbox DEV accounts name"
    default = "test-account"
}
variable "aws_organizations_account_sandboxdev_email" {
    description = "Sandbox DEV accounts email"
    default = "tb.test.logging.01@gmail.com"
}

variable "aws_organizations_account_sandboxprod_name" {
    description = "Sandbox PROD accounts name"
    default = "test-account"
}
variable "aws_organizations_account_sandboxprod_email" {
    description = "Sandbox PROD accounts email"
    default = "tb.test.logging.02@gmail.com"
}
