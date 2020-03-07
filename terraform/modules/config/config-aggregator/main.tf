#
# Configuration Aggregator
#
resource "aws_config_configuration_aggregator" "organization" {
  count      = var.aggregate_organization ? 1 : 0
  name       = "${var.config_name}_organization_aggregator"

  organization_aggregation_source {
    all_regions = true
    role_arn    = var.aggregator_role_arn
  }
}

resource "aws_config_aggregate_authorization" "lz_config_aggregate_auth" {
  account_id = var.authorization_account_id
  region     = var.region
}