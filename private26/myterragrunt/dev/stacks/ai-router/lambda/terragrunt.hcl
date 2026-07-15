include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "iam" {
  config_path = "../iam"

  mock_outputs = {
    iam_roles_arns = {
      "ai-router-lambda-role" = "arn:aws:iam::000000000000:role/mock"
    }
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

terraform {
  source = "../../../../../modules/lambda"
}

inputs = {
  functions = {
    ai_router = {
      function_name         = "my-ai-router"
      role_arn              = dependency.iam.outputs.iam_roles_arns["ai-router-lambda-role"]
      handler               = "index.handler"
      runtime               = "python3.12"
      timeout               = 10
      memory_size           = 256
      environment_variables = { OLLAMA_URL = "http://100.53.53.59:11434/api/generate" }
      ssm_environment_variables = {
        API_SHARED_SECRET = "/ai-router/api-shared-secret"
      }
      tags = {
        Name       = "ai-router"
        owner      = "my-devops"
        created_at = "2026-07-15"
      }
    }
  }
}
