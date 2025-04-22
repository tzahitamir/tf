terraform {

  backend "s3" {
    bucket         = "tzahi-temp" 
    key            = "tf/ecs/1/wtest.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = ["wittix"]
  }
}

# Reference existing subnets (Replace with actual values)
data "aws_subnets" "public" {
  filter {
    name   = "tag:public"
    values = ["true"]
  }
}
# Reference existing security group
data "aws_security_group" "ecs-sg" {
  name = "ecs-sg"
}
data "aws_security_group" "www" {
  name = "www-sg-allow-all"
}

resource "aws_ecs_cluster" "wtest" {
    name     = "wtest"
    setting {
        name  = "containerInsights"
        value = "enabled"
    }
}
#Define task definition
resource "aws_ecs_task_definition" "sampletd" {
  depends_on = [aws_ecs_cluster.wtest]
  family = "sampletd"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"

  container_definitions = jsonencode([
    {
      name      = "sample-app"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/sample-app:latest"
      cpu       = 10
      memory    = 256
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${aws_ecs_cluster.wtest.name}"
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
  ])
}
#Ddefine service
resource "aws_ecs_service" "sample-new" {
  depends_on = [aws_ecs_task_definition.sampletd]
  force_new_deployment = true
  name            = "sample-new"
  cluster         = "wtest"
  task_definition = "sampletd"
  desired_count   = 1
  launch_type = "FARGATE"
  availability_zone_rebalancing = "ENABLED" 

  network_configuration {
    subnets          = data.aws_subnets.public.ids
    security_groups  = [data.aws_security_group.ecs-sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.ecs_tg.arn 
    container_name   = "sample-app"
    container_port   = 8000
  }

}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name        = "/ecs/${aws_ecs_cluster.wtest.name}"
  retention_in_days = 7
}
resource "aws_iam_policy" "ecs_cloudwatch_logs" {
  name        = "ECSCloudWatchLogsPolicy"
  description = "Allows ECS to write logs to CloudWatch Logs"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:us-east-1:123456789012:log-group:/ecs/*:*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "ecs_logs_attach" {
  role       = "ecs_task_execution_role"
  policy_arn = aws_iam_policy.ecs_cloudwatch_logs.arn
}

resource "aws_alb" "ecs_alb" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.ecs-sg.id,data.aws_security_group.www.id]  
  subnets           = data.aws_subnets.public.ids
}

resource "aws_alb_target_group" "ecs_tg" {
  name        = "ecs-target-group"
  port        = 8000
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.existing_vpc.id
  target_type = "ip"
}

resource "aws_alb_listener" "ecs_listener" {
  load_balancer_arn = aws_alb.ecs_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-west-1:455178800756:certificate/bd625e85-1ad9-4ef4-bff2-d6fae28ab314"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ecs_tg.arn
  }
}
  
