########################################  Security groups   #########################################################

vpc_id = "vpc-50a6a535"

security_groups = {
  "web-sg-test1" = {
    name        = "web-sg-test1"
    description = "Security group for web servers"
    ingress_rules = [
      { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
     # { from_port = 8000, to_port = 8000, protocol = "tcp", cidr_blocks = ["172.0.0.0/24"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "web-sg-test1", Environment = "prod" }
  }

  "ssh-sg-test" = {
    name        = "ssh-sg-test"
    description = "Security group for ssh"
    ingress_rules = [
      { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
      
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "ssh-sg-test", Environment = "prod" }
  } 

  "allow-8000" = {
    name        = "allow-8000"
    description = "allow-8000"
    ingress_rules = [
      { from_port = 8000, to_port = 8000, protocol = "tcp", cidr_blocks = ["172.31.0.0/16"] }
      #{ from_port = 8000, to_port = 8000, protocol = "tcp", self = true }
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "allow-8000", Environment = "test" }
  } 
  
}

###########################################################  ecs vars  #########################################


ecs_clusters = {
  cluster-prod-test = {
    settings = [
      {
        name  = "containerInsights"
        value = "enabled"
      }
    ]
  }
  # cluster-dev = {
  #   settings = [
  #     {
  #       name  = "containerInsights"
  #       value = "enabled"
  #     }
  #   ]
  # }
}
##
aws_ecs_task_definition = {
  1 = {
    family                   = "td-test1"
    network_mode             = "awsvpc"
    memory                   = "512"
    cpu                      = "256"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
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
          awslogs-group         = "/ecs/td-test1"
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
  }
  2 = {
    family                   = "td-test2"
    network_mode             = "awsvpc"
    memory                   = "512"
    cpu                      = "256"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
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
          awslogs-group         = "/ecs/td-test2"
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
  }
}

aws_cloudwatch_log_group = {
  1 = {
    name              = "/ecs/td-test1"
    retention_in_days = "7"
  }
  2 = {
    name              = "/ecs/td-test2"
    retention_in_days = "7"
  }
}














# ecs_cluster_name = "mycluster"
# family             = "sampletd"
# memory             = "512"
# cpu                = "256"
# execution_role_arn = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
# requires_compatibilities = ["FARGATE"]
# #depends_on_resources = ["aws_ecs_cluster.wtest"]

# # JSON-encoded container definitions should be enclosed with <<EOF ... EOF
# container_definitions = <<EOF
# [
#   {
#     "name": "sample-app",
#     "image": "455178800756.dkr.ecr.eu-west-1.amazonaws.com/sample-app:latest",
#     "cpu": 10,
#     "memory": 256,
#     "essential": true,
#     "logConfiguration": {
#       "logDriver": "awslogs",
#       "options": {
#         "awslogs-group": "/tf/ecs/",
#         "awslogs-region": "eu-west-1",
#         "awslogs-stream-prefix": "ecs"
#       }
#     },
#     "portMappings": [
#       {
#         "containerPort": 8000,
#         "hostPort": 8000
#       }
#     ]
#   }
# ]
# EOF

#   ecs_service_name = "t1"
#   task_definition = "t1-td"
#   desired_count = "1"
#   launch_type = "FARGATE"
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
        Resource = "*"
      }]
    }
  }
}

############################################# IAM Roles #######################################################
iam_roles = {
  "ro-role-test" = {
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
my_ecs_task_execution_role_test = {
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

############################################# IAM policy attach #######################################################

role_policy_map = {
    "ro-role-test" = ["wrds-backup-policy-test"]
}
    # "app-role-2" = ["readonly", "fullaccess"]
#iam_role_attach= {
#  "ro-role_attach" = {
#    role   = "my_ecs_task_execution_role"
   # policy_key = "wecs-log-policy" # IAM policy key
#    policy_arn = aws_iam_policy.ecs-task-execution-role.arn
#}


#my_ecs_task_execution_role = {
#   role   = string
#    policy_arn   = string
#}

#}


############################################# IAM Users #######################################################










