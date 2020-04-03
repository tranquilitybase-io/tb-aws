variable "file_name"{
    description = "Lambda function file"
}

variable "code_hash"{
    description = "Code Hash"
}

variable "function_name"{
    description = "Lambda function name"
}

variable "function_handler"{
    description = "Function entrypoint in the code"
}

variable "function_role"{
    description = " IAM role attached to the Lambda Function"
}

variable "function_description"{
    description = "Description of the function"
}

variable "function_runtime"{
    description = "Function runtime image"
}

variable "tags"{
    description = "Function tags"
}
