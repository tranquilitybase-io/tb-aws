/*
* # GFT AWS LZ Key Pairs Service Terraform module
*
* Usage: Generic Terraform module to create AWS key pairs in order to using EC2 intances.
*/

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = var.public_key

  provisioner "local-exec" {
     command = "aws s3 cp ../temp--$TF_VAR_env_generation_date.key s3://$bucket/"
  }

  lifecycle { 
    ignore_changes = [public_key, tags]
  }

  tags       = var.tags
}