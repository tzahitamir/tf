terraform {
  backend "s3" {
    bucket         = "pp-ops" 
    key            = "tf/tf/test/rds-rnd.tfstate"
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
  vpc_id = data.aws_vpc.existing_vpc.id  # Optional but recommended for uniqueness
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

resource "aws_db_instance" "pp-dev" {
  identifier              = "pp-dev"
  instance_class          = "db.m6g.large"
  allocated_storage       = 500
  max_allocated_storage   = 2000
  engine                  = "mysql"
  engine_version          = "8.0.40"
  # Disable automated backups
  backup_retention_period = 0

  # Remove preferred backup and maintenance windows
  skip_final_snapshot          = true
  copy_tags_to_snapshot        = false
  delete_automated_backups     = true
  auto_minor_version_upgrade   = false
  username                = "admin"
  password                = "D1ll1gaf" # replace with a secret reference in production
  #snapshot_identifier     = data.aws_db_snapshot.latest_mysql.id
  publicly_accessible     = false
  multi_az                = false
  storage_type            = "gp3"
  db_subnet_group_name    = data.aws_db_subnet_group.selected.name
  vpc_security_group_ids  = [data.aws_security_group.mysql.id]
  tags = {
    Name = "pp-dev"
    created_by_tf = "true"
  }
  lifecycle {
    ignore_changes = [
      instance_class,
      allocated_storage,
      engine_version,
      max_allocated_storage
    ]
  }
}
