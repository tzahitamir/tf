terraform {
  backend "s3" {
    bucket         = "pp-ops" 
    key            = "tf/tf/test/playground.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-state-locking"
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
  region = "eu-west-2"
}

data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = ["pay-plus-prod-vpc-vpc"]
  }
}


data "aws_security_group" "mysql" {
  name   = "MySQL"
  vpc_id = data.aws_vpc.existing_vpc.id  
}


data "aws_db_snapshot" "latest_mysql" {
  most_recent = true
  snapshot_type = "automated"
  db_instance_identifier = "db-2"
}

data "aws_db_subnet_group" "selected" {
  name = "default-vpc-01688100f6fa51e2e"
}

##################################
data "aws_secretsmanager_secret" "rds_admin" {
  name = "rds_admin"
}
data "aws_secretsmanager_secret_version" "rds_admin" {
  secret_id = data.aws_secretsmanager_secret.rds_admin.id
}
locals {
  secret_string = jsondecode(data.aws_secretsmanager_secret_version.rds_admin.secret_string)
}

output "db_password" {
  value     = local.secret_string["admin"] # assuming the secret is a JSON with a "password" key
  sensitive = true
}

###################################