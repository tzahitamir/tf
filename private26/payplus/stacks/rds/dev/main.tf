data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["pay-plus-prod-vpc-vpc"]
  }
}

data "aws_security_group" "mysql-sg" {
  id = "sg-0e687d93225b22c2e"
}

# data "aws_subnets" "public" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.selected.id]
#   }
#   filter {
#     name   = "availability-zone"
#     values = ["eu-west-2b", "eu-west-2c"]
#   }
#   tags = {
#     Tier = "public"
#   }
# }

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


# module "mysql" {
#   source = "../../../../modules/rds"
#   engine = "mysql"  
#   engine_version = "8.0.42"
#   parameter_group_family     = "mysql8.0"
#   identifier     = "pp-mysql-dev10"
#   instance_class = "db.m6g.large"
#   allocated_storage = 200

#   db_name  = "dummy"
#   username = "admin"
#   secret_name = "rdsmysql/payplus/dev10"
#   subnet_ids         = data.aws_subnets.subnet_ids.ids
#   security_group_ids = [data.aws_security_group.mysql-sg.id]
#   multi_az = false
#   skip_final_snapshot = true
#   deletion_protection = false
#   tags = {
#     env = "dev"
#     service = "payplus"
#   }
# }



# module "postgres" {
#   source = "../../../../modules/rds"

#   identifier     = "pp-postgres-dev2"
#   engine         = "postgres"
#   engine_version = "17.4"
#   instance_class = "db.m6g.large"
#   allocated_storage = 200
#   db_name  = null

#   # This is the RDS MASTER / BOOTSTRAP USER
#   username = "rdsadmin"

#   create_secret = true
#   secret_name   = "rdspostgres/payplus/dev2"

#   subnet_ids         = var.private_subnets
#   security_group_ids = [aws_security_group.db.id]

#   multi_az = false

#   tags = {
#     env     = "dev"
#     service = "payplus"
#   }
# }

