/*
* # GFT AWS LZ Transit Gateway Network Manager Service Terraform module
*
* Usage: Generic Terraform module to Enable TGW Network Manager Service.
*/

locals {
  gn_tags = merge({"Name" = format("%s", var.global_network_name)}, var.tags)
}

data "template_file" "log_name" {
  template = "./modules/transit-gateway/tgw-net-manager/output.log"
}

data "local_file" "create-globalnet" {
  filename = data.template_file.log_name.rendered
  depends_on = [null_resource.aws_lz_ena_net_manager]
}

resource "null_resource" "aws_lz_ena_net_manager" {
  provisioner "local-exec" {
    command = "aws networkmanager create-global-network --description '${var.global_network_description}' --tags Key=Name,Value=${var.global_network_name} > ${data.template_file.log_name.rendered}"
  }
}


