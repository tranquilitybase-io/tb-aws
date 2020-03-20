resource "aws_ram_resource_share" "aws_lz_ram_shared" {
  count = length(var.ram_name) > 0 ? 1 : 0

  name   = var.ram_name
  allow_external_principals = var.ram_allow_external_principals
  tags = var.ram_tags

  depends_on = [null_resource.enable_aws_ram_organization]
}

resource "aws_ram_resource_association" "aws_lz_ram_association" {
  count = length(var.ram_resource_arn) > 0 ? 1 : 0

  resource_arn       = var.ram_resource_arn
  resource_share_arn = aws_ram_resource_share.aws_lz_ram_shared[0].id

  depends_on = [aws_ram_resource_share.aws_lz_ram_shared]
}

resource "aws_ram_principal_association" "aws_lz_ram_principal_association" {
  count = length(var.ram_principals) > 0 ? length(var.ram_principals) : 0

  principal = var.ram_principals
  resource_share_arn = aws_ram_resource_share.aws_lz_ram_shared[0].arn

  depends_on = [aws_ram_resource_association.aws_lz_ram_association]
}


