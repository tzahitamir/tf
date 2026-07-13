############################################################## ECS VARS  ################################################

variable "ecs_clusters" {
  type = map(object({
    settings = list(object({
      name  = string
      value = string
    }))
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
    task_role_arn            = optional(string)
    container_definitions    = list(any) 
    requires_compatibilities = list(string)
  }))
}

variable "aws_cloudwatch_log_group" {
  description = "aws_cloudwatch_log_group"
  type = map(object({
    name                     = string
    retention_in_days        = string
  }))
}