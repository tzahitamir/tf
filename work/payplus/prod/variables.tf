####################################  SG vars    ##########################################

variable "vpc_id" {
  description = "VPC ID for the Security Groups"
  type        = string
}

variable "security_groups" {
  description = "Map of security groups"
  type = map(object({
    name        = string
    description = string
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    tags = map(string)
  }))
}

############################################################## ECS VARS  ################################################
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
############################################# IAM policies #######################################################
variable "iam_policies" {
  description = "List of IAM policies"
  type        = map(object({
    description   = string
    policy_json   = any
  }))
}


############################################# IAM Roles #######################################################
variable "iam_roles" {
  description = "Map of IAM roles"
  type        = map(object({
    name   = string
    policy_json   = any
  }))
}

############################################# IAM policy attach #######################################################


variable "role_policy_map" {
  description = "Mapping of role names to list of policy names"
  type        = map(list(string))
}


############################################ IAM Users #######################################################