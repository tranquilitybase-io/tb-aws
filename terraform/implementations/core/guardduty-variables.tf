variable "key"{
    description = "Key Id that will be used for the bucket"
    type = string
    
}

variable "description"{
    description = "Key Description"
    type = string
}

variable "algorithm"{
    description= "Encryption algorithm for Findings bucket"
    type = string
}

variable "s3_guardduty_policy_name"{
    description= "Policy name for guardduty access to S3"
    type = string
}

variable "s3_guardduty_policy_description"{
    description= "Policy description for guardduty access to S3"
    type = string
}