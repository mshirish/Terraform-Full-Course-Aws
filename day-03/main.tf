terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  # Configuration options
    region = "us-east-2"
}

# Create a S3 bucket
resource "aws_s3_bucket" "tf_test_shirish_bucket" {
  bucket = "my-tf-test-shirish-bucket-101"

  tags = {
    Name        = "My bucket 2.0"
    Environment = "Prod"
  }
}
