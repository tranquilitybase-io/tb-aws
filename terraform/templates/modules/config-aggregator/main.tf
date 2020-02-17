#
# IAM Role
#
data "aws_region" "current" {}

data "aws_iam_policy_document" "aws_config_aggregator_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "aggregator" {
  count              = var.aggregate_organization ? 1 : 0
  name               = "${var.config_name}-aggregator-role"
  assume_role_policy = data.aws_iam_policy_document.aws_config_aggregator_role_policy.json
}

resource "aws_iam_role_policy_attachment" "aggregator" {
  count      = var.aggregate_organization ? 1 : 0
  role       = aws_iam_role.aggregator[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}

#
# Configuration Aggregator
#
resource "aws_config_configuration_aggregator" "organization" {
  count      = var.aggregate_organization ? 1 : 0
  depends_on = [aws_iam_role_policy_attachment.aggregator]
  name       = var.config_aggregator_name

  organization_aggregation_source {
    all_regions = true
    role_arn    = aws_iam_role.aggregator[0].arn
  }
}

resource "aws_config_aggregate_authorization" "LZ-config_aggregate_auth" {
  account_id = var.account_id
  region     = data.aws_region.current.name
}