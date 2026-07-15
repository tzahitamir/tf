variable "apis" {
  description = "Map of HTTP APIs (API Gateway v2) to create, each proxying to a Lambda function. Keys are unique identifiers."
  type = map(object({
    name                 = string
    lambda_invoke_arn    = string
    lambda_function_name = string
    route_key            = optional(string, "$default")
    stage_name           = optional(string, "$default")
    tags                 = map(string)
  }))
}
