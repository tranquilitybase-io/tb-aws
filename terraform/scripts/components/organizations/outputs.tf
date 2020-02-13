output "org_id" {
  value = concat(aws_organizations_organization.aws_lz_organization.*.id, [""])[0]
  description = "ID of the organization"
}