/*
* # GFT AWS LZ Transit Gateway Network Manager Service Terraform module
*
* Usage: Generic Terraform module to Enable TGW Network Manager Service.
*/

locals {
  file = jsondecode(data.local_file.create_globalnet.content)
}

resource "null_resource" "aws_lz_ena_net_manager" {
    provisioner "local-exec" {
    command = "aws networkmanager create-global-network --description '${local.file}' --tags Key=Name,Value=${var.global_network_name} > ${data.template_file.log_name.rendered}"
  }
}

resource "null_resource" "aws_lz_register_tgw_globalnet" {
  provisioner "local-exec" {
    command = "aws networkmanager register-transit-gateway --global-network-id ${local.file.GlobalNetwork.GlobalNetworkId} --transit-gateway-arn ${var.tgw_arn}"
  }
  depends_on = [null_resource.aws_lz_ena_net_manager]
}



