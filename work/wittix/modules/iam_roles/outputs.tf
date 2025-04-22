output "iam_roles_arns" {
  description = "ARNs of the created IAM roles"
  value       = { for k, v in aws_iam_role.myroles : k => v.arn }
}




