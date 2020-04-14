/*
* # GFT AWS LZ Key Pairs Service Terraform module
*
* Usage: Generic Terraform module to create AWS key pairs in order to using EC2 intances.
*/

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = var.public_key
 
  lifecycle { 
    ignore_changes = [public_key, tags]
  }

  tags       = var.tags
}