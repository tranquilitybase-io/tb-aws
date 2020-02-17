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

variable "disable_email_notification"{
    type = boolean
    default = false 
}

variable "regions" {
  default = [
    "us-east-1",
    "us-east-2",
    "us-west-1",
    "us-west-2",
    "ca-central-1",
    "eu-central-1",
    "eu-west-1",
    "eu-west-2",
    "eu-west-3",
    "ap-northeast-1",
    "ap-northeast-2",
    "ap-southeast-1",
    "ap-southeast-2",
    "ap-south-1",
    "sa-east-1"
  ]
}