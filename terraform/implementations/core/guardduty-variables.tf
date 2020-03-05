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