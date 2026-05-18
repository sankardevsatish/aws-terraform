terraform {
  cloud {
    organization = "vinuinspain"   # your HCP Terraform org name

    workspaces {
      name = "aws-terraform"           # your workspace name in HCP
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # 6.x required for terraform query list block support
    }
  }
  required_version = ">= 1.14.0" # 1.14+ required for terraform query command
}

provider "aws" {
  region = var.aws_region
}
