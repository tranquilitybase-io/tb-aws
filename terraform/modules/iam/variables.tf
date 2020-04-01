variable "role_name" {
    description = "Role Name"
    default = ""
}

variable "policy" {
    description = "Policy text"
    type = string
    default = ""
}

variable "policy_arn" {
    description = "Policy ARN"
    type = string
    default = ""
}

variable "policy_attach_name" {
    description = "Policy Attachment Name"
    default = ""
}
variable "policy_name" {
    description = "Policy Name"
    default = ""
}

variable "assume_role_policy" {
    description = "Assume Role Policy"
    default = ""
}

variable "policy_description" {
    description = "Policy Description"
    default = ""
}

variable "policy_attach_users" {
    description = "Policy attach users"
    default = []
}

variable "policy_attach_roles" {
    description = "Policy attach roles"
    default = []
}

variable "policy_attach_groups" {
    description = "Policy attach groups"
    default = []
}

variable "role_tags" {
    description = "Required Tags"
    type = map(string)
     default = {}
}


variable "policy_attach_security"{
    type = string
}