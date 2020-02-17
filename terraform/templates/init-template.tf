provider "aws" {
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