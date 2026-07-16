include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "sg" {
  config_path = "../sg"

  mock_outputs = {
    security_group_ids = {
      rds_sg = "sg-00000000000000000"
    }
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

terraform {
  source = "../../../../../modules/rds-postgress"
}

inputs = {
  create = true

  identifier = "postgres-core"

  engine                 = "postgres"
  engine_version         = "16"
  parameter_group_family = "postgres16"

  instance_class    = "db.t4g.micro"
  allocated_storage = 20

  db_name  = "postgres"
  username = "postgres"

  secret_name = "/core/postgres-core-credentials"

  subnet_ids = [
    "subnet-0e0b3200d979d2240",
    "subnet-0d0ec79bd05bf225a"
  ]
  security_group_ids = [dependency.sg.outputs.security_group_ids["rds_sg"]]

  port = 5432

  multi_az                = false
  backup_retention_period = 1
  deletion_protection     = false
  skip_final_snapshot     = true

  tags = {
    Name       = "postgres-core"
    owner      = "my-devops"
    created_at = "2026-07-16"
  }
}
