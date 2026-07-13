#roles can be find by running tf output at /home/tf/repo/ops/tf/wittix/stacks/iam_roles/dev
#policies can be find by running tf output at /home/tf/repo/ops/tf/wittix/stacks/iam_policies/dev

locals {
  role_policy_map = {
    "ecs-task-execution-role-prod" = ["ecs-task-secrets-policy-prod","ecs-task-s3-policy-prod","ecs-task-sqs-policy-prod","wittix-opensearch-r-w-prod"],
    "wittix-ecs-task-execution-role-dev" = ["s3-wittix-rw-dev","wittix-ecr-policy-ro","wittix-secrets-policy-dev","wittix-sqs-policy-dev","wittix-opensearch-r-w-dev"]
  }
#This is used if needed to attach AWS managed policies to roles
  # role_policy_map_aws = {
  #   "wittix-ecs-task-execution-role-dev" = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess", "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"]
  # }
}

