output "endpoint" {
  value = var.create ? aws_db_instance.this[0].endpoint : null
}

output "secret_name" {
  value = var.create ? aws_secretsmanager_secret.this[0].name : null
}

output "secret_arn" {
  value = var.create ? aws_secretsmanager_secret.this[0].arn : null
}
