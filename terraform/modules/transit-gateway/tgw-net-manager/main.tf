/*
* # GFT AWS LZ Transit Gateway Network Manager Service Terraform module
*
* Usage: Generic Terraform module to Enable TGW Network Manager Service.
*/

resource "null_resource" "aws_lz_ena_net_manager" {
  provisioner "local-exec" {
    command = "create-global-network --description ${var.global_network_description} --tags ${merge(  {"Name" = format("%s", var.global_network_name)}, var.tags,)}"
  }
}