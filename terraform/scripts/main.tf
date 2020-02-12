provider "aws" {
  region = "us-east-2"
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
