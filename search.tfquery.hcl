# -----------------------------------------------------------
# Terraform Search & Import Query
# Requires: Terraform >= 1.14 | AWS Provider >= 6.38.0
#
# Resources confirmed supported in AWS Provider 6.38 - 6.40:
#   6.38: aws_vpc_endpoint, aws_ssm_document
#   6.39: aws_eks_cluster
#   6.40: aws_config_config_rule, aws_glue_job, aws_ssm_association
#
# NOT supported yet (coming in 6.41+):
#   aws_nat_gateway, aws_instance, aws_s3_bucket
#
# Removed: aws_msk_cluster (requires MSK subscription not available in this account)
#
# Usage:
#   terraform query    # discover resources & generate import blocks
#   terraform apply    # import discovered resources
# -----------------------------------------------------------

# --- Networking (available since 6.38) ---

list "aws_vpc_endpoint" "unmanaged" {
  provider = aws

  config {
    region = "eu-west-2"

    filter {
      name   = "vpc-endpoint-state"
      values = ["available"]
    }
  }
}

# --- Kubernetes (available since 6.39) ---

list "aws_eks_cluster" "unmanaged" {
  provider = aws

  config {
    region = "eu-west-2"
  }
}

# --- Config & Compliance (available since 6.40) ---

list "aws_config_config_rule" "unmanaged" {
  provider = aws

  config {
    region = "eu-west-2"
  }
}

# --- SSM (available since 6.38) ---

list "aws_ssm_document" "unmanaged" {
  provider = aws

  config {
    region = "eu-west-2"
  }
}

# --- SSM Association (available since 6.40) ---

list "aws_ssm_association" "unmanaged" {
  provider = aws

  config {
    region = "eu-west-2"
  }
}

# --- Data & Analytics (available since 6.40) ---

list "aws_glue_job" "unmanaged" {
  provider = aws

  config {
    region = "eu-west-2"
  }
}

list "aws_instance" "unmanaged" {
  provider = aws

  config {
    region = "eu-west-2"

    filter {
      name   = "instance-state-name"
      values = ["running"]
    }
  }
}