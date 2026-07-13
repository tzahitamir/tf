############################################# IAM Roles #######################################################
iam_roles = {
  "ro-role-prod" = {
  name = "ro-role-prod"
  policy_json = {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::455178800756:user/tzahi.t"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
 },
  "ecs-task-execution-role-prod" = {
  name = "ecs-task-execution-role-prod"
  policy_json = {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
   ]
  }
  tags = {
    "Name" = "ecs-task-execution-role-prod"
    "Terraform" = "true"
    "Environment" = "prod"
  }
  },
  "wittix-ecs-task-execution-role-dev" = {
  name = "wittix-ecs-task-execution-role-dev"
  policy_json = {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
   ]
  }
  tags = {
    "Name" = "wittix-ecs-task-execution-role-dev"
    "Terraform" = "true"
    "Environment" = "dev"
  }
  }
}


