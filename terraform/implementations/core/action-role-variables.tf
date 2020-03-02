variable "security_role_name" {
    description = "Role for security account"
    default = "SecurityCrossAccountRole"
}
variable "logarchive_role_name" {
    description = "Role for logarchive account"
    default = "LogarchiveCrossAccountRole"
}
variable "sharedservices_role_name" {
    description = "Role for sharedservices account"
    default = "SharedservicesCrossAccountRole"
}
variable "network_role_name" {
    description = "Role for network account"
    default = "NetworkCrossAccountRole"
}
variable "org_admin_role" {
    description = "Role for network account"
    default = "AWSLZCoreOUAdminRole"
}

