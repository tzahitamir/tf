# Output the IAM role ARN
output "role_arn" {
  value       = aws_iam_role.irsa.arn
  description = "IAM Role ARN for IRSA"
}