locals {
  common_tags = {
    ProjectID = var.awslz_proj_id
    Environment = var.awslz_environment
    AccountID = var.awslz_account_id
  }
}

variable "aws_default_region" {
  type        = string
  description = "Default region for the landing zone"
}

variable "aws_access_key_id" {
  type        = string
  description = "access key"
}

variable "aws_secret_access_key" {
  type        = string
  description = "access key"
}

variable "tag_key_project_id" {
  type = string
  default = "ProjectId"
}
variable "tag_key_environment" {
  type = string
  default = "Environment"
}
variable "tag_key_account_id" {
  type = string
  default = "AccountId"
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
