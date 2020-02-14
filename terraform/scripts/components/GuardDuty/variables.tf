variable "cloudwatch_notify_frecuency" {
  type = string
  description = "Frecuency that cloudwatch events will be notified. Accepted values: FIFTEEN_MINUTES, ONE_HOUR, SIX_HOURS."
  default = "SIX_HOURS"
  validation {
    # regex(...) fails if it cannot find a match'
    condition = var.cloudwatch_notify_frecuency == "FIFTEEN_MINUTES" || cloudwatch_notify_frecuency=="ONE_HOUR" || cloudwatch_notify_frecuency=="SIX_HOURS"
    error_message = "The Notifications frecuency value in not valid."
  }
}

variable "member_invite_message" {
  type = string
  description = "Message that the invite will display"
  default = ""  
}

variable "auto_accept_invites" {
  type = boolean
  description = "Members will accept invties automatically (recommended)"
  default = true 
}