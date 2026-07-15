variable "functions" {
  description = "Map of Lambda functions to create. Keys are unique function identifiers. This module only creates the function shell with a placeholder deployment package; actual code deployment happens via a separate workflow (e.g. aws lambda update-function-code)."
  type = map(object({
    function_name          = string
    role_arn               = string
    handler                = optional(string, "index.handler")
    runtime                = optional(string, "python3.12")
    timeout                = optional(number, 3)
    memory_size            = optional(number, 128)
    environment_variables  = optional(map(string), {})
    tags                   = map(string)
  }))
}
