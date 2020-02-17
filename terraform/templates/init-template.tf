provider "aws" {
  region = var.aws_default_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  version = "~> 2.48"
}

terraform {
  required_version = ">= 0.12.20"
}

provider "local" {
  version = "~> 1.4"
}

provider "null" {
  version = "~> 2.1"
}