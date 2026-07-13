

data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = ["wittix"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:public"
    values = ["true"]
  }
}

data "aws_security_group" "ecs-sg" {
  name = "ecs-sg"
}

data "aws_security_group" "www" {
  name = "www-sg-allow-all"
}

resource "aws_ecs_cluster" "wtest" {
    name     = var.ecs_cluster_name
    setting {
        name  = "containerInsights"
        value = "enabled"
    }
}
#Define task definition
resource "aws_ecs_task_definition" "sampletd" {
 # depends_on = var.depends_on
  
  family = var.family
  network_mode             = "awsvpc"
  requires_compatibilities = var.requires_compatibilities
  memory                   = var.memory
  cpu                      = var.cpu
  execution_role_arn       = var.execution_role_arn
  container_definitions = var.container_definitions  
}


#Define service
resource "aws_ecs_service" "sample-new" {
 # depends_on = [aws_ecs_task_definition.sampletd]
  force_new_deployment = true
  name            = var.ecs_service_name
  cluster         = var.ecs_cluster_name
  task_definition = var.family
  desired_count   = var.desired_count
  launch_type = var.launch_type
  availability_zone_rebalancing = "ENABLED" 

  network_configuration {
    subnets          = data.aws_subnets.public.ids
    security_groups  = [data.aws_security_group.ecs-sg.id]
    assign_public_ip = true
  }

  #load_balancer {
  #  target_group_arn = aws_alb_target_group.ecs_tg.arn 
  #  container_name   = "sample-app"
  #  container_port   = 8000
  #}

}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name        = "/tf/ecs/"
  retention_in_days = 7
}


#resource "aws_iam_policy" "ecs_cloudwatch_logs" {
#  name        = "ECSCloudWatchLogsPolicy"
#  description = "Allows ECS to write logs to CloudWatch Logs"

#  policy = jsonencode({
#    Version = "2012-10-17",
#    Statement = [
#      {
#        Effect   = "Allow",
#        Action   = [
#          "logs:CreateLogStream",
#          "logs:PutLogEvents"
#        ],
#        Resource = "arn:aws:logs:eu-west-1:455178800756:log-group:/tf/*:*"
#      }
#    ]
#  })
#}
resource "aws_iam_role_policy_attachment" "ecs_logs_attach" {
  role       = "ecs_task_execution_role"
  #policy_arn = aws_iam_policy.ecs_cloudwatch_logs.arn
  policy_arn = aws_iam_policy.my_tf_policies.arn
}



## consider moving load balancers to a diffiernt modeule

#resource "aws_alb" "ecs_alb" {
#  name               = "ecs-alb"
#  internal           = false
#  load_balancer_type = "application"
#  security_groups    = [data.aws_security_group.ecs-sg.id,data.aws_security_group.www.id]  
#  subnets           = data.aws_subnets.public.ids
#}

#resource "aws_alb_target_group" "ecs_tg" {
#  name        = "ecs-tg"
#  port        = 8000
#  protocol    = "HTTP"
#  vpc_id      = data.aws_vpc.existing_vpc.id
#  target_type = "ip"
#}

#resource "aws_alb_listener" "ecs_listener" {
#  load_balancer_arn = aws_alb.ecs_alb.arn
#  port              = 443
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = "arn:aws:acm:eu-west-1:455178800756:certificate/bd625e85-1ad9-4ef4-bff2-d6fae28ab314"

#  default_action {
#    type             = "forward"
#    target_group_arn = aws_alb_target_group.ecs_tg.arn
#  }
#}
  
