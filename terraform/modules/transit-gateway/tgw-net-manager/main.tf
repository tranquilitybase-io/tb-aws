/*
* # GFT AWS LZ Transit Gateway Network Manager Service Terraform module
*
* Usage: Generic Terraform module to Enable TGW Network Manager Service.
*/

resource "null_resource" "aws_lz_global_network" {
    provisioner "local-exec" {
    command = "aws networkmanager create-global-network --description '${var.global_network_description}' --tags Key=Name,Value=${var.global_network_name} > ${data.template_file.log_name.rendered} --profile network"
  }
}





