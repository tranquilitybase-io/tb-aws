terraform {
  required_version = ">= 0.12.20"
  /*backend "s3" {
    bucket          = "control-terraform-states-aws-lz-v01"
    key             = "terraform/terraform.tfstate"
    dynamodb_table  = "terraform-states"
  }*/
  required_providers {
    aws =   "~> 2.48"
    local = "~> 1.4"
    null =  "~> 2.1"
    archive = "~> 1.3"
    template = "~> 2.1"
  }
}