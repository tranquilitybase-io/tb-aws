/*
* # GFT AWS LZ Transit Gateway Network Manager Service Terraform module
*
* Usage: Generic Terraform module to Register TGW to Global Network.
*/

resource "null_resource" "aws_lz_register_tgw_globalnet" {

  count = length(var.globalnet_id) > 0 ? 1 : 0

  provisioner "local-exec" {
    command = "aws networkmanager register-transit-gateway --global-network-id ${var.globalnet_id} --transit-gateway-arn ${var.tgw_arn}"
  }
}