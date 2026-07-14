output "security_group_ids" {
  description = "IDs of the created security groups."
  value       = { for k, sg in aws_security_group.this : k => sg.id }
}
