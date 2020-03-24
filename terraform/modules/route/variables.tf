variable "route_table"{
    description = "Route table where the route will be added"
    default = []
}
variable "destination"{
    description = "CIDR destionation"
    default = ""
}
variable "transit_gateway"{
    description = "The transit gateway Id ehre traffic is routed"
    default = ""
}