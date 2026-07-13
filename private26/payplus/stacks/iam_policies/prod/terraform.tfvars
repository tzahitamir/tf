iam_policies = {
  "pp-read-secret-prod" = {
    description = "Allows listing all secrets, but reading only production postgres secrets"
    policy_json = {
      Version = "2012-10-17"
      Statement = [
        {
          # Statement 1: Allow listing all secrets (required for the console/SDK list)
          Effect   = "Allow"
          Action   = ["secretsmanager:ListSecrets"]
          Resource = "*"
        },
        {
          # Statement 2: Restrict Read/Describe to the specific path
          Effect   = "Allow"
          Action   = [
            "secretsmanager:GetSecretValue",
            "secretsmanager:DescribeSecret"
          ]
          Resource = [
            "arn:aws:secretsmanager:eu-west-2:713117837264:secret:postgress/prod/*"
          ]
        }
      ]
    }
  }
}