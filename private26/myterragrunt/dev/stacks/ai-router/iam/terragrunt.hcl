include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../modules/iam_roles"
}

inputs = {
  iam_roles = {
    ai-router-lambda-role = {
      name = "ai-router-lambda-role"
      policy_json = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Principal = {
              Service = "lambda.amazonaws.com"
            }
            Action = "sts:AssumeRole"
          }
        ]
      })
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      ]
    }
  }
}
