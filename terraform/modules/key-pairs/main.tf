/*
* # GFT AWS LZ Key Pairs Service Terraform module
*
* Usage: Generic Terraform module to create AWS key pairs in order to using EC2 intances.
*/

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = var.public_key

  provisioner "local-exec" {
     command = "echo -------------------; ls -la; pwd; ls ../" 
     #"aws s3 cp path_to_my_file ${aws_s3_bucket.my-bucket.id}"
     #aws s3 cp temp--${TF_VAR_env_generation_date}.key s3://${bucket}/ > /dev/null 2>&1 && echo "Check your S3 bucket to download files"
  }

  lifecycle { 
    ignore_changes = [public_key, tags]
  }

  tags       = var.tags
}