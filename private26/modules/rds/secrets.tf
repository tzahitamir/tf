# resource "random_password" "this" {
#   length  = 32
#   special = true
# }

# resource "aws_secretsmanager_secret" "this" {
#   name = var.secret_name
#   tags = var.tags
# }

# resource "aws_secretsmanager_secret_version" "this" {
#   secret_id = aws_secretsmanager_secret.this.id

#   secret_string = jsonencode({
#     username = var.username
#     password = random_password.this.result
#     engine   = "mysql"
#     host     = aws_db_instance.this.address
#     port     = aws_db_instance.this.port
#     dbname   = var.db_name
#   })
# }
