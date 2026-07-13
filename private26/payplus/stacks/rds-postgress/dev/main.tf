data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["pay-plus-prod-vpc-vpc"]
  }
}

data "aws_security_group" "postgress-internal-sg" {
  id = "sg-0e3ed7fa0273dc924"
}

data "aws_subnets" "subnet_ids" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "availability-zone"
    values = ["eu-west-2b", "eu-west-2c"]
  }
  tags = {
    Tier = "private"
  }
}


# module "postgres" {
#   source = "../../../../modules/rds-postgress"
  
#   engine = "postgres"
#   engine_version = "17.4"
#   parameter_group_family     = "postgres17"
#   identifier     = "pp-postgres-dev1"
#   instance_class = "db.m6g.large"
#   allocated_storage = 200
#   db_name  = "dummy"
#   username = "pgadmin"
#   secret_name   = "rdspostgres/payplus/dev1"

#   subnet_ids         = data.aws_subnets.subnet_ids.ids
#   security_group_ids = [data.aws_security_group.postgress-internal-sg.id]
#   multi_az = false
#   skip_final_snapshot = true
#   deletion_protection = false

#   tags = {
#     env     = "dev"
#     service = "payplus"
#   }
# }

