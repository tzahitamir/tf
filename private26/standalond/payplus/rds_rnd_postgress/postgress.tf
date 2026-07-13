terraform {
  backend "s3" {
    bucket         = "pp-ops" 
    key            = "tf/tf/test/rds-rnd-postgres.tfstate"
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

data "aws_security_group" "postgres-internal" {
  name   = "postgres-internal"
  vpc_id = data.aws_vpc.existing_vpc.id  # Optional but recommended for uniqueness
}


data "aws_db_subnet_group" "selected" {
  name = "default-vpc-01688100f6fa51e2e"
}

##################################
data "aws_secretsmanager_secret" "rds_postgres_admin" {
  name = "rds_postgres_admin"
}

data "aws_secretsmanager_secret_version" "rds_postgres_admin" {
  secret_id = data.aws_secretsmanager_secret.rds_postgres_admin.id
}

locals {
  secret_string = jsondecode(data.aws_secretsmanager_secret_version.rds_postgres_admin.secret_string)

  db_username = keys(local.secret_string)[0]
  db_password = local.secret_string[local.db_username]
}


resource "aws_db_instance" "pp-dev-pgs" {
  identifier              = "pp-dev-pgs"
  #instance_class          = "db.m6g.large"
  instance_class          = "db.t4g.medium"
  allocated_storage       = 100
  max_allocated_storage   = 2000
  engine                  = "postgres"
  engine_version          = "17.4"
  # Disable automated backups
  backup_retention_period = 0

  # Remove preferred backup and maintenance windows
  skip_final_snapshot          = true
  copy_tags_to_snapshot        = false
  delete_automated_backups     = true
  auto_minor_version_upgrade   = false
  username                     = local.db_username
  password                     = local.db_password
  publicly_accessible     = false
  multi_az                = false
  storage_type            = "gp3"
  db_subnet_group_name    = data.aws_db_subnet_group.selected.name
  vpc_security_group_ids  = [data.aws_security_group.postgres-internal.id]
  tags = {
    Name = "pp-dev-pgs"
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
