variable "ami_version" {
    description = "Amazon Machine Image"
    default     = ""
}
variable "instance_type" {
    description = "Instance type"
    default     = ""
}

variable "subnet_id" {
    description = "Subnet id to deploy instance"
    default     = ""
}
