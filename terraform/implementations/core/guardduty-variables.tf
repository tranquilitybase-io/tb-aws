
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
}

variable "s3_guardduty_policy_description"{
    description= "Policy description for guardduty access to S3"
    type = string
}

variable "key_permission"{
    description ="Name for the key permission"
    type = string
}

variable "key_principal"{
    description = "Principals that will have access to the key"
    default = "guardduty.amazonaws.com"
    type = string
}

variable "key_operations"{
    description = "Operations that will be allowed to the principal"
    default = ["GenerateDataKey"]
    type = list
}