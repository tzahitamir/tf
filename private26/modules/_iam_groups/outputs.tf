output "aws_iam_group" {
  description = "list of IAM group"
  value       = { for k, v in aws_iam_group.this : k => v.name }
}