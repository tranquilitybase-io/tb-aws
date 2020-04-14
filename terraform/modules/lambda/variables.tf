variable "file_name"{
    description = "Lambda function file"
    type = string
}

variable "code_hash"{
    description = "Code Hash"
    type = string
}

variable "function_name"{
    description = "Lambda function name"
    type = string
}

variable "function_handler"{
    description = "Function entrypoint in the code"
    type = string
}

variable "function_role"{
    description = " IAM role attached to the Lambda Function"
    type = string
}

variable "function_description"{
    description = "Description of the function"
    type = string
}

variable "function_runtime"{
    description = "Function runtime image"
    type = string
}

variable "tags"{
    description = "Function tags"
    type = map(string)
}
