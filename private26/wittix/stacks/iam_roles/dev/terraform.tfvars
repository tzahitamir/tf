############################################# IAM Roles #######################################################
iam_roles = {
  "ro-role-test1" = {
  name = "ro-role-test"
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
}
my_ecs_task_execution_role_test1 = {
  name = "my-ecs-task-execution-role-test"
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

}
}
