variable "create_attachment" {
    description = "Flag to create VPC Attachment"
    default = true
}

variable "subnets_ids" {
    description= "Identifiers of subnets"
    type = list(string)
}

variable "transit_gateway_id" {
    description= "Transit gateway Id"
    type = string
}

variable "vpc_id" {
    description= "VPC ID"
    type = string
}

variable "tags" {
    description = "Tags for attachment VPC"
  default = {} 
}

variable "attach_name" {
    description = "Attachment Name"
    default = ""
}