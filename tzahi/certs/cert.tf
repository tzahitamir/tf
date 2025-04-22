
 terraform {

  backend "s3" {
    bucket         = "tzahi-temp" # REPLACE WITH YOUR BUCKET NAME
    key            = "tf/ecs/1/cert.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_acm_certificate" "ecs_cert" {
  domain_name       = "*.wittix.com"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
#will output the record to create in Cloudflare
output "acm_dns_validation_records" {
  value = aws_acm_certificate.ecs_cert.domain_validation_options
}
#aws acm list-certificates

#ssl_policy        = "ELBSecurityPolicy-2016-08"
#certificate_arn   = aws_acm_certificate.ecs_cert.arn
