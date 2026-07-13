
output "alb_arns_map" {
  value       = { for k, v in aws_lb.albs : k => v.arn }
}


output "aws_lb_listener_arns_map" {
  value       = { for k, v in aws_lb_listener.alb_listener: k => v.arn }
}

# output "target_group_arns" {
#   description = "ARNs of the created IAM policies"
#   value       = { for k, v in aws_lb_target_group.tgs : k => v.arn }
#}

