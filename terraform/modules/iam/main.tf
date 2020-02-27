resource "aws_iam_role" "aws_lz_iam_role" {
    count   = length(var.name) > 0 ? 1 : 0
    
    name    = var.role_name
    assume_role_policy = var.assume_role_policy
    tags = var.role_tags
}

resource "aws_iam_policy" "aws_lz_iam_policy" {
    count   = length(var.policy_name) > 0 ? 1 : 0

    name        = var.policy_name
    description = var.policy_description
    policy =  var.policy
}

resource "aws_iam_policy_attachment" "aws_lz_iam_attach_policy" {
    count      = length(var.policy_attach_name) > 0 ? 1 : 0
    
    name       = var.policy_attach_name
    users      = var.policy_attach_users
    roles      = var.policy_attach_roles
    groups     = var.policy_attach_groups
    policy_arn = var.policy_arn

    depends_on = [
        aws_iam_role.aws_lz_iam_role,
        aws_iam_policy.aws_lz_iam_policy
    ]
}