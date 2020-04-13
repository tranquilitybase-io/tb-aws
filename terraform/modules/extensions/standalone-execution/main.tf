/*
* # GFT AWS LZ RAM Service Terraform module
*
* Usage: Terraform module which enable RAM Service for the organization.
*/

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

  lifecycle {
    ignore_changes = [enable_ram_org, ]
  }
}




