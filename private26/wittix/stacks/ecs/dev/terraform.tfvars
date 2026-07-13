

ecs_clusters = {
  cluster-tf-test = {
    settings = [
      {
        name  = "containerInsights"
        value = "enabled"
      }
    ]
  }
}
##
aws_ecs_task_definition = {
  1 = {
    family                   = "tf-test"
    network_mode             = "awsvpc"
    memory                   = "512"
    cpu                      = "256"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/wittix-ecs-task-execution-role-dev"
    container_definitions    = [
    {
      name      = "sample-app"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/sample-app:latest"
      cpu       = 10
      memory    = 256
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/tf-test"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }  
      ]
    }
  ]
    requires_compatibilities = ["FARGATE"]
 },
  2 = {
    family                   = "td-test77"
    network_mode             = "awsvpc"
    memory                   = "512"
    cpu                      = "256"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/wittix-ecs-task-execution-role-dev"
    container_definitions    = [
    {
      name      = "sample-app2"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/sample-app:latest"
      cpu       = 10
      memory    = 256
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/tf-test"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = []
      # portMappings = [
      #   {
      #     containerPort = 8000
      #     hostPort      = 8000
      #   }  
      # ]
    }
  ]
    requires_compatibilities = ["FARGATE"]
 }

}

aws_cloudwatch_log_group = {
  1 = {
    name              = "/ecs/tf-test"
    retention_in_days = "7"
  }
  # 2 = {
  #   name              = "/ecs/td-test2"
  #   retention_in_days = "7"
  # }
}