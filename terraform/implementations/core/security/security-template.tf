module "aws_lz_aggregate_security_sns_topic" {
  source = "./modules/snstopic"
  
   providers = {
    aws = aws.security-account
  } 

  sns_topic_name = var.aggregate_topic_name
  required_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_account_security.account_id, (var.tag_key_name) = "Aggregate Security" }
}

module "aws_lz_guardduty_sns_topic" {
  source = "./modules/snstopic"

  providers = {
    aws = aws.security-account
  }

  sns_topic_name = var.guardduty_topic_name
  required_tags  = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = local.security_account_id, (var.tag_key_name) = "Guardduty findings" }

  attach_policy = true
  policy = "${data.aws_iam_policy_document.sns_topic_policy.json}"
}


data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Publish"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        "${local.security_account_id}",
      ]
    }

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    resources = [
      "${module.aws_lz_aggregate_security_sns_topic.topic_arn}",
    ]

    sid = "__default_statement_ID"
  }
}