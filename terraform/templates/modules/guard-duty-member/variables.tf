variable "cloudwatch_notify_frecuency" {
  type = string
  default = "SIX_HOURS"
}

variable "member_invite_message" {
  type = string
  default = ""  
}

variable "invite_members"{
  type = boolean
  default = true 
}

variable "auto_accept_invites" {
  type = boolean
  default = true 
}


variable "enable_detector" {
  type = boolean
  default = true 
}

variable "disable_email_notification"{
    type = boolean
    default = false 
}