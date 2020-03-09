/* resource "aws_iam_policy" "s3_guardduty_iam_policy" {  
    name        = var.policy_name
    description = var.policy_description
    policy =  var.policy
}
 */
/* resource "aws_iam_policy_attachment" "aws_lz_iam_attach_policy" {
    count      = length(var.policy_attach_name) > 0 ? 1 : 0
    
    name       = var.policy_attach_name
    users      = var.policy_attach_users
    roles      = var.policy_attach_roles
    groups     = var.policy_attach_groups
    policy_arn = var.policy_arn
} */

resource "aws_s3_bucket_policy" "guardduty_bucket_policy" {
  bucket = var.bucket_name
  policy = var.policy
  depends_on = [module.s3_findings.bucket_name_arn]
}