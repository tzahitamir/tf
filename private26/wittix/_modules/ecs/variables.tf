variable "ecs_clusters" {
  description = "Map of ECS cluster names and settings"
  type = map(object({
    settings = list(object({
      name  = string
      value = string
    }))
  }))
}

variable "aws_cloudwatch_log_group" {
  description = "aws_cloudwatch_log_group"
  type = map(object({
    name                     = string
    retention_in_days        = string
  }))
}

variable "aws_ecs_task_definition" {
  description = "task Definition"
  type = map(object({
    family                   = string
    network_mode             = string
    memory                   = string
    cpu                      = string
    execution_role_arn       = string
    container_definitions    = list(any) 
    requires_compatibilities = list(string)
  }))
}

variable "aws_ecs_service_definition" {
  description = "aws_ecs_service"
  type = map(object({
    force_new_deployment          = bool
    name                          = string
    cluster                       = string
    desired_count                 = number
    launch_type                   = string
    task_definition               = string
    availability_zone_rebalancing = string
    network_configuration         = list(object({
        subnets          = list(string)
        security_groups  = list(string)
        assign_public_ip = bool
      }))
   load_balancer         = list(object({
        container_name   = string
        container_port  = number
        target_group_arn = string
      }))
  }))    
}

  # family = var.family
  # network_mode             = "awsvpc"
  # requires_compatibilities = var.requires_compatibilities
  # memory                   = var.memory
  # cpu                      = var.cpu
  # execution_role_arn       = var.execution_role_arn
  # container_definitions    = var.container_definitions