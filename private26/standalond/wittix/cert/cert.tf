#Create a certificate using ACM and DNS validation in cloudfalre, 
#after entring the dns record manually in cloudflare, the certificate will be issued 
terraform {
  backend "s3" {
    bucket         = "tzahi-temp" 
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
resource "aws_acm_certificate" "wittix_me_cert" {
  domain_name       = "*.wittix.me"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

#will output the record to create in Cloudflare
output "ecs_cert_validation_records" {
  value = aws_acm_certificate.ecs_cert.domain_validation_options
}
output "wittix_me_cert_validation_records" {
  value = aws_acm_certificate.wittix_me_cert.domain_validation_options
}

#aws acm list-certificates