variable "ram_tags" {
  default = ""
}
variable "ram_create" {
  type        = bool
  default     = true
}
variable "ram_share" {
  type        = bool
  default     = true
}
variable "ram_resource_arn" {
  type = string
  default = ""
}
variable "ram_resource_shared_arn" {
  type = string
  default = ""
}
variable "ram_principals" {
  type = string
  default = ""
}
variable "ram_allow_external_principals" {
  type = bool
  default = true
}
variable "ram_name" {
  type = string
  default = ""
}