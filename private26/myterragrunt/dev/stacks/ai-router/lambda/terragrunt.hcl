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

dependency "sg" {
  config_path = "../sg"

  mock_outputs = {
    security_group_ids = {
      ai_router_lambda_sg = "sg-00000000000000000"
    }
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

dependency "postgres" {
  config_path = "../../core/postgres-core"

  mock_outputs = {
    endpoint = "mock-postgres-core.us-east-1.rds.amazonaws.com:5432"
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

terraform {
  source = "../../../../../modules/lambda"
}

inputs = {
  functions = {
    ai_router = {
      function_name = "my-ai-router"
      role_arn      = dependency.iam.outputs.iam_roles_arns["ai-router-lambda-role"]
      handler       = "index.handler"
      runtime       = "python3.12"
      timeout       = 29
      memory_size   = 256
      environment_variables = {
        OLLAMA_URL  = "http://172.31.13.125:11434/api/generate"
        DB_ENDPOINT = dependency.postgres.outputs.endpoint
      }
      ssm_environment_variables = {
        API_SHARED_SECRET = "/ai-router/api-shared-secret"
      }
      secretsmanager_environment_variables = {
        DB_CREDENTIALS_JSON = "/core/postgres-core-credentials"
      }
      vpc_subnet_ids         = ["subnet-0e0b3200d979d2240"]
      vpc_security_group_ids = [dependency.sg.outputs.security_group_ids["ai_router_lambda_sg"]]
      tags = {
        Name       = "ai-router"
        owner      = "my-devops"
        created_at = "2026-07-15"
      }
    }
  }
}
