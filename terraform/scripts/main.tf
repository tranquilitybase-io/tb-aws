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

variable "tag_key_project_id" {
  type = string
  default = "project_id"
}
variable "tag_key_environment" {
  type = string
  default = "environment"
}
variable "tag_key_account_id" {
  type = string
  default = "account_id"
}
variable "tag_key_name" {
  type = string
  default = "name"
}
variable "awslz_proj_id" {
  type = string
  default = "11111"
}
variable "awslz_environment" {
  type = string
  default = "DEV"
}
variable "awslz_account_id" {
  type = string
  default = "22222"
}


