terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

provider "aws" {
  alias = "west"
  region = "us-west-2"
}

module "create_s3" {
  source = "./storage"
  bucket_name = "rahul-demobucket2050"
  providers = {
    aws.west = aws.west
   }
}

output "my_bucket_domain_name" {
  value = module.create_s3.my_bucket_domain_name
}

