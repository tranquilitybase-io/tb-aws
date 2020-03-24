variable "subnets_ids"{
    description= "Identifiers of subnets"
    type = list
}

variable "transit_gateway_id"{
    description= "Transit gateway Id"
    type = string
}


variable "vpc_id"{
    description= "vpc_id"
    type = string
}

variable "tags" {
  default = {} 
}

variable "account_id"{
    default = ""
}