/*
* # GFT AWS LZ IAM role and policy Service Terraform module
*
* Usage: Generic Terraform module which handles IAM roles, policies and their attachment.
*/

resource "aws_iam_role" "aws_lz_iam_role" {
    count   = length(var.role_name) > 0 ? 1 : 0
    
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

resource "aws_iam_role_policy_attachment" "role_policy_attach" {
  count      = var.role_policy_attach == true ? 1 : 0

  role       = aws_iam_role.aws_lz_iam_role[count.index].name
  policy_arn = var.policy_arn
}