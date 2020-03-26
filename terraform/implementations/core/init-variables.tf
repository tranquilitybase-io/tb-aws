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
  description = "Availability zones where the VPC will span"
  type = list(string)
  default = [data.aws_availability_zones.available.names[0],data.aws_availability_zones.available.names[1]]
}