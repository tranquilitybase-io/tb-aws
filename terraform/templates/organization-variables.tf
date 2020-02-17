variable "aws_organizations_account_sharedservices_name" {
    description = "Shared Services details"
    default ="sharedservice"
}
variable "aws_organizations_account_sharedservices_email" {
    description = "Shared Services details"
    default = "test.gft.aws.01@gmail.com"
}
variable "aws_organizations_account_logarchive_name" {
    description = "Log Archive accounts details"
    default = "logarchive"
}
variable "aws_organizations_account_logarchive_email" {
    description = "Log Archive accounts details"
    default = "test.gft.aws.02@gmail.com"
}
variable "aws_organizations_account_security_name" {
    description = "Security accounts details"
    default = "security"
}
variable "aws_organizations_account_security_email" {
    description = "Security accounts details"
    default = "test.gft.aws.03@gmail.com"
}
variable "org_tags" {
  default = {} 
}