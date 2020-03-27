/*
* # GFT AWS LZ Config Aggregator Terraform module
*
* Usage: Module to create an aggregator to set Config in a Multi Account environment. The aggregator will be set to all regions even futures region, also it will be attched to an Organization, so all the members of that Organization will be checked by the Config rules.
*/

resource "aws_config_configuration_aggregator" "organization" {
  count      = var.aggregate_organization ? 1 : 0
  name       = "${var.config_name}_organization_aggregator"

  organization_aggregation_source {
    all_regions = true
    role_arn    = aws_iam_role.aggregator_role[0].arn
  }
}

###Aggregate Role
resource "aws_iam_role" "aggregator_role" {
  count              = var.aggregate_organization ? 1 : 0
  name               = "${var.config_name}_aggregator_role"
  assume_role_policy = data.aws_iam_policy_document.aws_aggregator_role_policy.json
  tags = var.config_tags
}

resource "aws_iam_role_policy_attachment" "aggregator" {
  count      = var.aggregate_organization ? 1 : 0
  role       = aws_iam_role.aggregator_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}
###

resource "aws_config_aggregate_authorization" "lz_config_aggregate_auth" {
  account_id = var.authorization_account_id
  region     = var.region
}