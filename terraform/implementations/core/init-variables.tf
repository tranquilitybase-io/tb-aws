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

variable "vpc_azs"{
  description = "Third or more Az's where the VPC will span, by default 2 AZ's will be attached to the VPC."
  type = list(string)
  default = []
}