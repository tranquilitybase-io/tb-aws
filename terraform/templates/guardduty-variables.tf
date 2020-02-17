variable "cloudwatch_notify_frecuency" {
  description = "Frecuency for CloudWatch Events to be notified. Accepted values: FIFTEEN_MINUTES, ONE_HOUR, SIX_HOURS."
  default = "SIX_HOURS"
  validation {
    condition = var.cloudwatch_notify_frecuency == "FIFTEEN_MINUTES" || var.cloudwatch_notify_frecuency=="ONE_HOUR" || var.cloudwatch_notify_frecuency=="SIX_HOURS"
    error_message = "The Notifications frecuency value in not valid."
  }
}

variable "invite_members"{
  description = "Send GuardDuty invites to member accounts"
  default = true 
}

variable "member_invite_message" {
  description = "Message that the invite will display"
  default = ""  
}

variable "disable_email_notification"{
  description = "Disable email notification for members"
  default = false
}