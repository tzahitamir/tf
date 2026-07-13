resource "aws_db_subnet_group" "this" {
  name       = var.identifier
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_db_parameter_group" "this" {
  name   = "${var.identifier}-pg"
  family = var.parameter_group_family
  tags   = var.tags
}

resource "random_password" "this" {
  length  = 32
  special = false
}

resource "aws_secretsmanager_secret" "this" {
  name = var.secret_name
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id

  secret_string = jsonencode({
    username = var.username
    password = random_password.this.result
    engine   = var.engine
    dbname   = var.db_name
  })
}

resource "aws_db_instance" "this" {
  identifier = var.identifier

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_type      = "gp3"

  db_name  = var.db_name // this is the initial database to create
  username = var.username
  password = random_password.this.result

  port = var.port

  multi_az = var.multi_az
  vpc_security_group_ids = var.security_group_ids
  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection
  skip_final_snapshot     = var.skip_final_snapshot

  parameter_group_name   = aws_db_parameter_group.this.name
  db_subnet_group_name   = aws_db_subnet_group.this.name

  tags = var.tags

#   depends_on = [
#     aws_secretsmanager_secret.this
#   ]
}
