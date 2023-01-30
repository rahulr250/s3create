terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
      configuration_aliases = [ aws.west ]
    }
  }
}

variable "bucket_name" {
  type = string
  description = "The name of the S3 bucket, must be globally unique"
}

resource "aws_s3_bucket" "my_bucket" {
  provider = aws.west
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  provider = aws.west
  bucket                  = aws_s3_bucket.my_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "my_bucket_domain_name" {
  value = aws_s3_bucket.my_bucket.bucket_domain_name
}
