resource "aws_ram_resource_share" "aws_lz_ram_shared" {
  count = var.ram_create && var.ram_share ? 1 : 0

  name   = coalesce(var.ram_create, var.ram_share)
  allow_external_principals = var.ram_allow_external_principals
  tags = var.ram_tags
}

resource "aws_ram_resource_association" "aws_lz_ram_association" {
  count = var.ram_create && var.ram_share ? 1 : 0

  resource_arn       = var.ram_resource_arn
  resource_share_arn = var.ram_resource_shared_arn
}

resource "aws_ram_principal_association" "aws_lz_ram_principal_association" {
  count = var.ram_create && var.ram_share ? length(var.ram_principals) : 0

  principal = var.ram_principals[count.index]
  resource_share_arn = var.ram_resource_shared_arn[count.index].arn
}
