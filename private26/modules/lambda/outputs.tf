output "function_names" {
  description = "Names of the created Lambda functions."
  value       = { for k, f in aws_lambda_function.this : k => f.function_name }
}

output "function_arns" {
  description = "ARNs of the created Lambda functions."
  value       = { for k, f in aws_lambda_function.this : k => f.arn }
}

output "invoke_arns" {
  description = "Invoke ARNs of the created Lambda functions (for API Gateway integration)."
  value       = { for k, f in aws_lambda_function.this : k => f.invoke_arn }
}
