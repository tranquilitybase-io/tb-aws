
variable "sns_topic_name" {
  description = "SNS Topic Name"
  default = ""
}

variable "kms_master_key_id" {
  description = "KMS by default for SNS topic"
  default = "alias/aws/sns"
}

variable "required_tags" {
  description = "Required Tags"
  default = {} 
}

variable "attach_policy"{
  description = "Attach a custom policy to the SNS"
  default = false
}

variable "policy"{
  description = "SNS Policy"
  default = ""
}