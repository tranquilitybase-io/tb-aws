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

  lifecycle {prevent_destroy = true}
}




