# output "target_group_arns" {
#   description = "ARNs of the created IAM policies"
#   value       = { for k, v in aws_lb_target_group.tgs : k => v.arn }
# }




output "nlb_arns_map" {
  #value = module.nlb.lb_arns
  value       = { for k, v in aws_lb.nlbs : k => v.arn }
}

