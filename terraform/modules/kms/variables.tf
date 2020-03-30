
 variable "key_description"{
   default = ""
   description = "KMS key Description"
 }
 
variable "kms_tags" {
  default = {}
  description = "Required Tags"
}