
terraform {
  backend "s3" {
    bucket = "ram06012610.bucket"
    key = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}




provider "aws" {
  region = "us-east-1"
}