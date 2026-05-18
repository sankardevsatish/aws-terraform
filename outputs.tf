output "bucket_id" {
  description = "ID (name) of the created S3 bucket"
  value       = aws_s3_bucket.main.id
}

output "bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = aws_s3_bucket.main.arn
}

output "bucket_domain_name" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket.main.bucket_domain_name
}

# Uncomment below after enabling the data "aws_s3_bucket" "existing" block in s3.tf
# output "existing_bucket_arn" {
#   description = "ARN of the looked-up existing bucket"
#   value       = data.aws_s3_bucket.existing.arn
# }
