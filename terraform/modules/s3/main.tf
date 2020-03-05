resource "aws_s3_bucket_policy" "aws_lz_s3_bucket_policy" {
    count   = length(var.bucket_id) > 0 ? 1 : 0
    
    bucket   = var.bucket_id
    policy = var.s3_bucket_policy
}
