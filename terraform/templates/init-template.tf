provider "aws" {
  version = "~> 2.48"
}

terraform {
  required_version = ">= 0.12.20"
  backend "s3" {
    bucket          = "control-terraform-states-aws-lz-v01"
    key             = "terraform/terraform.tfstate"
    dynamodb_table  = "terraform-states"
  }
}

provider "local" {
  version = "~> 1.4"
}

provider "null" {
  version = "~> 2.1"
}




##############
# US REGIONS #
##############
# us-east-1 
provider "aws" {
  alias  = "multiregion"
  region = "us-east-2"

# us-east-2 
provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
}

# us-west-1 
provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}

# us-west-2
provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
}

##############
# AP REGIONS #
##############

# ap-east-1 
provider "aws" {
  alias  = "ap-east-1"
  region = "ap-east-1"
}

# ap-south-1 
provider "aws" {
  alias  = "ap-south-1"
  region = "ap-south-1"
}

# ap-northeast-2 
provider "aws" {
  alias  = "ap-northeast-2"
  region = "ap-northeast-2"
}

# ap-northeast-1 
provider "aws" {
  alias  = "ap-northeast-1"
  region = "ap-northeast-1"
}

# ap-southeast-1 
provider "aws" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"
}

# ap-southeast-2 
provider "aws" {
  alias  = "ap-southeast-2"
  region = "ap-southeast-2"
}

##############
# CA REGIONS #
##############

# ca-central-1
provider "aws" {
  alias  = "ca-central-1"
  region = "ca-central-1"
}

##############
# EU REGIONS #
##############

# eu-central-1
provider "aws" {
  alias  = "eu-central-1"
  region = "eu-central-1"
}

# eu-west-1
provider "aws" {
  alias  = "eu-west-1"
  region = "eu-west-1"
}

# eu-west-2
provider "aws" {
  alias  = "eu-west-2"
  region = "eu-west-2"
}

# eu-west-3
provider "aws" {
  alias  = "eu-west-3"
  region = "eu-west-3"
}

# eu-nort-1
provider "aws" {
  alias  = "eu-nort-1"
  region = "eu-nort-1"
}

##############
# ME REGIONS #
##############

# me-south-1
provider "aws" {
  alias  = "eu-south-1"
  region = "eu-south-1"
}

##############
# SA REGIONS #
##############

# sa-east-1
provider "aws" {
  alias  = "sa-east-1"
  region = "sa-east-1"
}