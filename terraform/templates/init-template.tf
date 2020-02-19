provider "aws" {
  version = "~> 2.48"
}

terraform {
  required_version = ">= 0.12.20"
  backend "s3" {
    bucket  = "my-tf-test-bucket-drk"
    key     = "terraform/terraform.tfstate"
  }
}

provider "local" {
  version = "~> 1.4"
}

provider "null" {
  version = "~> 2.1"
}