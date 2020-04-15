/*
* # GFT AWS LZ Key Pairs Service Terraform module
*
* Usage: Generic Terraform module to create AWS key pairs in order to using EC2 intances.
*/

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = var.public_key

  provisioner "local-exec" {
     command = "echo -------------------; ls -la; pwd" #"aws s3 cp path_to_my_file ${aws_s3_bucket.my-bucket.id}"
  }

  lifecycle { 
    ignore_changes = [public_key, tags]
  }

  tags       = var.tags
}