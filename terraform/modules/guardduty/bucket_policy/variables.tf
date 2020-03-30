
variable "bucket_name" {
    description = "S3 Bucket Name"
    type = string
    default = ""
}

variable "bucket_arn" {
    description = "S3 Bucket ARN"
    type = string
    default = ""
}

variable "policy" {
    description = "Bucket Policy"
    type = string
    default = ""
}

variable "policy_description" {
    description = "Bucket Policy Description"
    type = string
    default = ""
}