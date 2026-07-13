

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

#using a map variable, the map name is also the name of the cluster


resource "aws_ecs_task_definition" "tasks" {
  for_each = var.aws_ecs_task_definition
  #familiy is the task definiton name
  family                   = each.value.family
  network_mode             = each.value.network_mode
  requires_compatibilities = each.value.requires_compatibilities
  memory                   = each.value.memory
  cpu                      = each.value.cpu
  execution_role_arn       = each.value.execution_role_arn
  container_definitions    = jsonencode (each.value.container_definitions)
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  for_each = var.aws_cloudwatch_log_group
  
  name = each.value.name
  retention_in_days = each.value.retention_in_days
}


resource "aws_ecs_cluster" "clusters" {
  for_each = var.ecs_clusters

  name = each.key

  dynamic "setting" {
    for_each = each.value.settings
    content {
      name  = setting.value.name
      value = setting.value.value
    }
  }
}


resource "aws_ecs_service" "services" {
  for_each = var.aws_ecs_service_definition
  
  name                            = each.value.name
  cluster                         = each.value.cluster
  desired_count                   = each.value.desired_count
  launch_type                     = each.value.launch_type
  task_definition                 = each.value.task_definition
  availability_zone_rebalancing   = each.value.availability_zone_rebalancing
  force_new_deployment            = each.value.force_new_deployment
  dynamic "network_configuration" {
    for_each = each.value.network_configuration
    content {
      subnets          = network_configuration.value.subnets
      security_groups  = network_configuration.value.security_groups
      assign_public_ip = network_configuration.value.assign_public_ip
    }
  }
  dynamic "load_balancer" {
    for_each = each.value.load_balancer

  content {
    target_group_arn = load_balancer.value.target_group_arn
    container_name   = load_balancer.value.container_name
    container_port   = load_balancer.value.container_port
    }
  }
}

# resource "aws_ecs_task_definition" "sampletd" {
  
#   family = var.family
#   network_mode             = "awsvpc"
#   requires_compatibilities = var.requires_compatibilities
#   memory                   = var.memory
#   cpu                      = var.cpu
#   execution_role_arn       = var.execution_role_arn
#   container_definitions    = var.container_definitions  
# }

