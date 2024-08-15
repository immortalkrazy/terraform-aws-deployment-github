# Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider Configuration

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# 9. Ubuntu Server
module "ec2" {
  source = "../../modules/ec2"
}
