
variable "aggregate_topic_name" {
  default = "aws_lz_aggregate_security_sns_topic"
  description = "Name of topic for Security Account"
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