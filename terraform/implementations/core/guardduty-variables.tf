
variable "description"{
    description = "Key Description"
    default = "Allow Guarduty to access bucket"
    type = string
}

variable "algorithm"{
    description= "Encryption algorithm for Findings bucket"
    type = string
    default = "aws:kms"
}

variable "s3_guardduty_policy_name"{
    description= "Policy name for guardduty access to S3"
    type = string
    default = "AllowGuardduty"
}

variable "s3_guardduty_policy_description"{
    description= "Policy description for guardduty access to S3"
    type = string
    default= "Allows Guardduty to write in S3 bucket"
}

variable "config_tags" {
  default = {}
}