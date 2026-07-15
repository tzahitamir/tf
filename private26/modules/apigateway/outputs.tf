output "api_ids" {
  description = "IDs of the created HTTP APIs."
  value       = { for k, a in aws_apigatewayv2_api.this : k => a.id }
}

output "api_endpoints" {
  description = "Invoke endpoint URLs of the created HTTP APIs."
  value       = { for k, a in aws_apigatewayv2_api.this : k => a.api_endpoint }
}
