resource "aws_s3_bucket_policy" "aws_lz_s3_bucket_policy" {
    count   = length(var.bucket_name) > 0 ? 1 : 0
    
    bucket   = var.bucket_name
    policy = var.s3_bucket_policy
}