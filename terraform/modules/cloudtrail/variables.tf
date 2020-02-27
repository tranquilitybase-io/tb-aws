
variable "cloudtrail_name" {
  description = "The name of the AWS CloudTrail instance."  
}

variable "region" {
  description = "The name of the Region"
}

variable "bucket_name" {
  description = "The name of the S3 Bucket Log"  
}

variable "bucket_arn" {
  description = "The name of the S3 Bucket Log"  
}

variable "s3_log_prefix" {
  description = "S3 prefix"
}

variable "sns_topic" {
  default = "cloudtrail_sns_topic" 
}

variable "cloudwatch_log_group" {
  description = "cloudwatch_log_group"
  default  = "cloudwatch_log_group"
}

variable "multi_region_trail" {
    description = "is_multi_region_trail TRUE - FALSE"
    type = bool
    default = true
}

variable "organization_trail" {
    description = "organization_trail"
    type = bool
    default = true
}

variable "enable_logging" {
    description = "enable_logging TRUE - FALSE"
    type = bool
    default = true
}

variable "include_global_events" {
    description = "Indicates whether the trail is publishing events from global services, such as IAM, to the log files."
    type = bool
    default = true
}

variable "enable_log_file_validation" {
    description = "enable_log_file_validation TRUE - FALSE"
    type = bool
    default = true
}

variable "logs_retencion_days" {
    description = "Specifies the number of days you want to retain CloudTrail log events in the CloudWatch Logs."
    type = number
    default = 14
    #AllowedValues: [1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653]
}

variable "required_tags" {
  default = {} 
}

