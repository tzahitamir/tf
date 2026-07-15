include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "lambda" {
  config_path = "../lambda"

  mock_outputs = {
    invoke_arns    = { ai_router = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:000000000000:function:mock/invocations" }
    function_names = { ai_router = "mock-function" }
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

terraform {
  source = "../../../../../modules/apigateway"
}

inputs = {
  apis = {
    ai_router = {
      name                 = "ai-router-api"
      lambda_invoke_arn    = dependency.lambda.outputs.invoke_arns["ai_router"]
      lambda_function_name = dependency.lambda.outputs.function_names["my-ai-router"]
      route_key            = "$default"
      stage_name           = "$default"
      tags = {
        Name       = "ai-router-api"
        owner      = "my-devops"
        created_at = "2026-07-15"
      }
    }
  }
}
