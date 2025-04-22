output "iam_policy_arns" {
  description = "ARNs of the created IAM policies"
  value       = { for k, v in aws_iam_policy.this : k => v.arn }
}




