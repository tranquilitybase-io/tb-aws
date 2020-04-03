
variable "aggregate_topic_name" {
  default = "aws_lz_aggregate_security_sns_topic"
  description = "Name of topic for Security Account"
}

variable "guardduty_topic_name"{
  default = "aws_lz_guardduty_sns_topic"
  description = "Name of topic for guardduty findings notification"
}


variable "function_name"{
  default = "aws_lz_guarduty_findings_lambda"
  description = "Name of the lambda function for guarduty findings"
}

variable "function_handler"{
  default = "guarduty_findings"
  description = "Function entrypoint in the code"
}

variable "lambda_role_name"{
  default = "AWSLZRoleForLambda"
  description = "Role that will be attached to the lambda function"
}

variable "function_description"{
  default = "Function that will be triggered by CloudWatch events eith GuardDuty findings"
  description = "Function description"
}

variable "function_runtime"{
  default = "python3.8"
  description = "Runtime for lambda execution"
}