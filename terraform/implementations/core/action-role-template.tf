data "aws_iam_policy_document" "aws_lz_assume_role_security" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${module.aws_lz_account_security.account_id}:root"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "aws_lz_assume_role_logarchive" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${module.aws_lz_account_logarchive.account_id}:root"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "aws_lz_assume_role_sharedservices" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${module.aws_lz_account_sharedservices.account_id}:root"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "aws_lz_assume_role_network" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${module.aws_lz_account_network.account_id}:root"]
    }

    effect = "Allow"
  }
}

#"SNS:GetTopicAttributes",
#"SNS:SetTopicAttributes",
#"SNS:AddPermission",
#"SNS:RemovePermission",
#"SNS:DeleteTopic",
#"SNS:Subscribe",
#"SNS:ListSubscriptionsByTopic",
#"SNS:Publish",
#"SNS:Receive"
data "aws_iam_policy_document" "aws_lz_role_policy_security"{
    statement {
        actions = [
            "iam:CreateRole"
        ]
        resources = [
            "arn:aws:iam:::*",
            ]
    }
    statement {
            actions = [
                "sns:CreateTopic",
                "sns:SetTopicAttributes",
                "sns:Subscribe"
            ]
            resources = [
                "arn:aws:sns:::*",
            ]
        
    } 
}

#"s3:GetBucketAcl",
#"s3:GetBucketPolicy",
#"s3:GetBucketPolicyStatus",
#"s3:PutBucketAcl",
#"s3:PutBucketLogging",
#"s3:PutEncryptionConfiguration",
#"s3:ListAllMyBuckets",
#"s3:GetBucketLocation" 
data "aws_iam_policy_document" "aws_lz_role_policy_logarchive"{
    statement {
        actions = [
            "s3:CreateBucket",
            "s3:PutBucketPolicy"
        ]
        resources = [
            "arn:aws:s3:::*",
            ]
    }
}

data "aws_iam_policy_document" "aws_lz_role_policy_sharedservices"{
    statement {
        actions = [
            "s3:ListAllMyBuckets",
            "s3:GetBucketLocation",
        ]
        resources = [
            "arn:aws:s3:::*",
            ]
    }
    statement {
            actions = [
                "s3:ListAllMyBuckets",
                "s3:GetBucketLocation",
            ]
            resources = [
                "arn:aws:s3:::*",
            ]
        
    }    
}

data "aws_iam_policy_document" "aws_lz_role_policy_network"{
    statement {
        actions = [
            "s3:ListAllMyBuckets",
            "s3:GetBucketLocation",
        ]
        resources = [
            "arn:aws:s3:::*",
            ]
    }
}

/*module "aws_lz_iam_role_security" {
    source = "./modules/iam"
    name = var.security_role_name
    assume_role_policy = data.aws_iam_policy_document.aws_lz_assume_role_security.json
    role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "action-role" }
}

module "aws_lz_iam_role_logarchive" {
    source = "./modules/iam"
    name = var.logarchive_role_name
    assume_role_policy = data.aws_iam_policy_document.aws_lz_assume_role_logarchive.json
    role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "action-role" }
}

module "aws_lz_iam_role_sharedservices" {
    source = "./modules/iam"
    name = var.sharedservices_role_name
    assume_role_policy = data.aws_iam_policy_document.aws_lz_assume_role_sharedservices.json
    role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "action-role" }
}

module "aws_lz_iam_role_network" {
    source = "./modules/iam"
    name = var.network_role_name
    assume_role_policy = data.aws_iam_policy_document.aws_lz_assume_role_network.json
    role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "action-role" }
}

module "aws_lz_iam_policy_security" {
    source = "./modules/iam"
    policy_name = "SecurityPolicy"
    policy_description = "Security Policy"
    policy = data.aws_iam_policy_document.aws_lz_role_policy_security.json
    role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "action-role" }
}


module "aws_lz_iam_policy_logarchive" {
    source = "./modules/iam"
    policy_name = "LogArchivePolicy"
    policy_description = "Logarchive Policy"
    policy = data.aws_iam_policy_document.aws_lz_role_policy_logarchive.json
    role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "action-role" }
}

module "aws_lz_iam_policy_sharedservices" {
    source = "./modules/iam"
    policy_name = "SharedServicesPolicy"
    policy_description = "Shared-Services Policy"
    policy = data.aws_iam_policy_document.aws_lz_role_policy_sharedservices.json
    role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "action-role" }
}

module "aws_lz_iam_policy_network" {
    source = "./modules/iam"
    policy_name = "NetworkPolicy"
    policy_description = "Network Policy"
    policy = data.aws_iam_policy_document.aws_lz_role_policy_network.json
    role_tags = { (var.tag_key_project_id) = var.awslz_proj_id, (var.tag_key_environment) = var.awslz_environment, (var.tag_key_account_id) = module.aws_lz_organization_main.master_account_id, (var.tag_key_name) = "action-role" }
}

module "aws_lz_iam_attach_policy_security"{
    source = "./modules/iam"
    policy_attach_name = "Attach Security policy on security role"
    policy_attach_roles = [module.aws_lz_iam_role_security.role_name]
    policy_arn = module.aws_lz_iam_policy_security.policy_arn
}

module "aws_lz_iam_attach_policy_logarchive"{
    source = "./modules/iam"
    policy_attach_name = "Attach Logarchive policy on log-archive role"
    policy_attach_roles = [module.aws_lz_iam_role_logarchive.role_name]
    policy_arn = module.aws_lz_iam_policy_logarchive.policy_arn
}

module "aws_lz_iam_attach_policy_sharedservices"{
    source = "./modules/iam"
    policy_attach_name = "Attach shared-services policy on shared-services role"
    policy_attach_roles = [module.aws_lz_iam_role_sharedservices.role_name]
    policy_arn = module.aws_lz_iam_policy_sharedservices.policy_arn
}

module "aws_lz_iam_attach_policy_network"{
    source = "./modules/iam"
    policy_attach_name = "Attach network policy on network role"
    policy_attach_roles = [module.aws_lz_iam_role_network.role_name]
    policy_arn = module.aws_lz_iam_policy_network.policy_arn
}*/