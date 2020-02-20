variable "cloudwatch_notify_frecuency" {
  type = string
  default = "SIX_HOURS"
}

variable "member_invite_message" {
  type = string
  default = ""  
}

variable "invite_members"{
  type = bool
  default = true 
}

variable "disable_email_notification"{
    type = bool
    default = false 
}