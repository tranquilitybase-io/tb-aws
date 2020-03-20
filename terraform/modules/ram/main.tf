locals {
  ram_command = [
    "python3",
    "\"${path.module}/aws_ram.py\"",
  ]
}

resource "null_resource" "enable_aws_ram_organization" {
  count = var.enable_ram_org ? 1 : 0

  provisioner "local-exec" {
    command = join(" ",local.ram_command)
  }
}

resource "aws_ram_resource_share" "aws_lz_ram_shared" {
  count = length(var.ram_name) > 0 ? 1 : 0

  name   = var.ram_name
  allow_external_principals = var.ram_allow_external_principals
  tags = var.ram_tags
}

resource "aws_ram_resource_association" "aws_lz_ram_association" {
  count = length(var.ram_resource_arn) > 0 ? 1 : 0

  resource_arn       = var.ram_resource_arn
  resource_share_arn = aws_ram_resource_share.aws_lz_ram_shared[0].id
}

resource "aws_ram_principal_association" "aws_lz_ram_principal_association" {
  count = length(var.ram_principals) > 0 ? length(var.ram_principals) : 0

  principal = var.ram_principals
  resource_share_arn = aws_ram_resource_share.aws_lz_ram_shared[0].arn
}


