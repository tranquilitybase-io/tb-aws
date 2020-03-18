variable "subnets_ids"{
    description= "Identifiers of subnets"
    type = list
    default = []
}

variable "transit_gateway_id"{
    description= "Transit gateway Id"
    type = string
    default = ""
}


variable "vpc_id"{
    description= "vpc_id"
    type = string
    default = ""
}