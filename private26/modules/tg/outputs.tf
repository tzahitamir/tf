output "target_group_arns" {
  description = "ARNs of the created target groups"
  value       = { for k, v in aws_lb_target_group.tgs : k => v.arn }
}


