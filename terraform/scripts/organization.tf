/*resource "aws_organizations_account" "organization" {
  name  = "${var.aws_organizations_account_organization_name}"
  email = "${var.aws_organizations_account_organization_email}"
}
resource "aws_organizations_account" "sharedservices" {
  name  = "var.aws_organizations_account_sharedservices_name"
  email = "var.aws_organizations_account_sharedservices_email"
}
resource "aws_organizations_account" "logarchive" {
  name  = "var.aws_organizations_account_logarchive_name"
  email = "var.aws_organizations_account_logarchive_email"
}
resource "aws_organizations_account" "security" {
  name  = "var.aws_organizations_account_security_name"
  email = "var.aws_organizations_account_security_email"
}

resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  feature_set = "ALL"
}*/