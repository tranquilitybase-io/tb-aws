/*
* # GFT AWS LZ Transit Gateway Network Manager Service Terraform module
*
* Usage: Generic Terraform module to Enable TGW Network Manager Service.
*/

locals {
  gn_tags = merge({"Name" = format("%s", var.global_network_name)}, var.tags)
}

resource "null_resource" "aws_lz_ena_net_manager" {
    provisioner "local-exec" {
    command = "aws networkmanager create-global-network --description '${var.global_network_description}' --tags '[${local.gn_tags}]' > ${data.template_file.log_name.rendered}"
  }
}


