output "endpoint" {
  value = aws_db_instance.this.endpoint
}

output "secret_name" {
  value = aws_secretsmanager_secret.this.name
}

output "secret_arn" {
  value = aws_secretsmanager_secret.this.arn
}
