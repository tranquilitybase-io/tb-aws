

variable "s3_log_prefix" {
  description = "The S3 prefix for AWS Config logs."
  default = "awslz"
}
variable "_description"{
    description = "Key Description"
    default = "Allow Guarduty to access bucket"
    type = string
}

variable "_algorithm"{
    description= "Encryption algorithm for Findings bucket"
    type = string
    default = "aws:kms"
}

variable "_s3_guardduty_policy_name"{
    description= "Policy name for guardduty access to S3"
    type = string
    default = "AllowGuardduty"
}

variable "_s3_guardduty_policy_description"{
    description= "Policy description for guardduty access to S3"
    type = string
    default= "Allows Guardduty to write in S3 bucket"
} 

variable "_config_tags" {
  default = {}
}