variable "name" {
    type = string
    default = ""
}
variable "policy" {
    type = string
    default = ""
}
variable "policy_arn" {
    type = string
    default = ""
}
variable "description" {
    type = string
    default = ""
}
variable "users" {
    type = list(string)
    default = []
}
variable "roles" {
    type = list(string)
    default = []
}
variable "groups" {
    type = list(string)
    default = []
}
variable "policy_attach_name" {
    description = ""
    default = ""
}
variable "policy_name" {
    description = ""
    default = ""
}
variable "role_name" {
    description = ""
    default = ""
}
variable "assume_role_policy" {
    description = ""
    default = ""
}
variable "aws_iam_role" {
    description = ""
    default = ""
}
variable "policy_description" {
    description = ""
    default = ""
}
variable "policy_attach_users" {
    description = ""
    default = []
}
variable "policy_attach_roles" {
    description = ""
    default = []
}
variable "policy_attach_groups" {
    description = ""
    default = []
}
variable "role_tags" {
    type = map(string)
     default = {}
}


