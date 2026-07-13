############################################# IAM policies #######################################################

iam_policies = {
  "wecs-log-policy-test" = {
    description = "Allows ECS to write logs to CloudWatch"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = "arn:aws:logs:*:*:*"
      }]
    }
  }
  "wrds-backup-policy-test" = {
    description = "Allows RDS to create automated backups"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action   = ["rds:CreateDBSnapshot", "rds:DescribeDBSnapshots"]
        #Resource = "*"
        Resource = [
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/aws_secret_access_key/dev-6weMt2",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:centro_link.db.dev-juEtzV"
        ]
      }]
    }
  }
}
