variable "ecs_cluster_name" {
  description = "aws_ecs_cluster name"
  type        = string
}

variable "family" {
  description = "family"
  type        = string
}


variable "requires_compatibilities" {
  description = "List of compatibility modes for the ECS task (e.g., FARGATE, EC2)"
  type        = list(string)
  default     = ["FARGATE"] 
}

variable "memory" {
  description = "memory"
  type        = string
}
variable "cpu" {
  description = "cpu"
  type        = string
}

variable "execution_role_arn" {
  description = "execution_role_arn"
  type        = string
}

variable "container_definitions" {
  description = "JSON-encoded container definitions for ECS task"
  type        = string
}


variable "ecs_service_name" {
  description = "ecs service name"
  type        = string
}
   
variable "task_definition" {
  description = "task definition"
  type        = string
}

variable "desired_count" {
  description = "task desired count (how many containers will run)"
  type        = string
}
variable "launch_type" {
  description = "Fargate / EC2 launch type "
  type        = string
  default     = "FARGATE"
}