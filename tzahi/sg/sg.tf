
 terraform {

  backend "s3" {
    bucket         = "tzahi-temp" # REPLACE WITH YOUR BUCKET NAME
    key            = "tf/ecs/1/sg.tfstate"
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

resource "aws_security_group" "ecs" {
  name = "ecs-sg"
  #description = "A" Description change recreates the sg
  vpc_id      = "vpc-50a6a535"  

  ingress {
    from_port = 1
    to_port   = 65535
    protocol  = "tcp"
    #cidr_blocks = ["172.31.0.0/16","172.32.0.0/16"]
    cidr_blocks = ["172.31.0.0/16", "172.20.0.0/16"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1" # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Allow traffic in 172.31"
  }
}
resource "aws_security_group" "www" {
  name = "www-sg-allow-all"
  #description = "A" Description change recreates the sg
  vpc_id      = "vpc-50a6a535"  
 
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1" # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Allow traffic from www"
  }
}
