# output "nlb_listeners" {
#   description = "ARNs of the created IAM policies"
#   value       = { for k, v in aws_lb_listener.nlb_listeners : k => v.arn }
# }