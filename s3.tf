# -----------------------------------------------------------
# Create a new S3 bucket
# -----------------------------------------------------------
resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# -----------------------------------------------------------
# Import existing S3 buckets into Terraform state
#
# NOTE: The AWS Terraform provider does NOT have a data source
# to list all buckets. Use the AWS CLI to discover them first:
#
#   aws s3api list-buckets --query "Buckets[*].Name" --output table
#
# Then for each bucket you want to import:
#   1. Uncomment the matching import + resource block below.
#   2. Set the correct bucket name.
#   3. Run:
#        terraform plan    # preview the import
#        terraform apply   # apply the import
# -----------------------------------------------------------

# Data source: look up a specific EXISTING bucket by name
# Uncomment and set the bucket name to inspect an existing bucket.
#
# data "aws_s3_bucket" "existing" {
#   bucket = "your-existing-bucket-name"
# }

# -----------------------------------------------------------
# Import blocks (Terraform >= 1.5)
# -----------------------------------------------------------

# import {
#   to = aws_s3_bucket.imported_bucket_1
#   id = "your-existing-bucket-name-1"
# }
#
# resource "aws_s3_bucket" "imported_bucket_1" {
#   bucket = "your-existing-bucket-name-1"
# }

# import {
#   to = aws_s3_bucket.imported_bucket_2
#   id = "your-existing-bucket-name-2"
# }
#
# resource "aws_s3_bucket" "imported_bucket_2" {
#   bucket = "your-existing-bucket-name-2"
# }
