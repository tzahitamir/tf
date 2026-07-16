variable "functions" {
  description = "Map of Lambda functions to create. Keys are unique function identifiers. This module only creates the function shell with a placeholder deployment package; actual code deployment happens via a separate workflow (e.g. aws lambda update-function-code)."
  type = map(object({
    function_name          = string
    role_arn               = string
    handler                = optional(string, "index.handler")
    runtime                = optional(string, "python3.12")
    timeout                = optional(number, 3)
    memory_size            = optional(number, 128)
    environment_variables                = optional(map(string), {})
    ssm_environment_variables            = optional(map(string), {}) # env var name => SSM SecureString parameter name
    secretsmanager_environment_variables = optional(map(string), {}) # env var name => Secrets Manager secret ID/ARN (raw secret_string, e.g. a JSON blob)
    vpc_subnet_ids                       = optional(list(string), [])
    vpc_security_group_ids    = optional(list(string), [])
    tags                      = map(string)
  }))
}
