variable "ram_name" {
  description = "RAM service name"
  type = string
  default = ""
}

variable "ram_tags" {
  description = "Required Tags"
  default = {}
}

variable "ram_resource_arn" {
  description = "RAM resource ARN"
  type = string
  default = ""
}

variable "ram_principals" {
  description = "RAM principals"
  type = string
  default = ""
}

variable "ram_allow_external_principals" {
  description = "RAM allow external principals"
  type = bool
  default = true
}
