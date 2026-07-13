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
      cidr_blocks = optional(list(string), []) # Default to empty list
      self        = optional(bool, false)      # Default to false
    }))
    egress_rules = list(object({
      from_port   = optional(number)
      to_port     = optional(number) 
      protocol    = optional(string) 
      cidr_blocks = optional(list(string), [])
    }))
    tags = map(string)
  }))
}

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


#variable should be defined here only if using tfvars
# variable "aws_ecs_service_definition" {
#   description = "aws_ecs_service"
#   type = map(object({
#     force_new_deployment          = bool
#     name                          = string
#     cluster                       = string
#     desired_count                 = number
#     launch_type                   = string
#     task_definition               = string
#     availability_zone_rebalancing = bool
#     network_configuration         = list(object({
#         subnets          = list(string)
#         security_groups  = list(string)
#         assign_public_ip = string
#       }))
#    # load_balancer    = list(any)
#   }))    
# }

# variable "family" {
#   description = "family"
#   type        = string
# }


# variable "requires_compatibilities" {
#   description = "List of compatibility modes for the ECS task (e.g., FARGATE, EC2)"
#   type        = list(string)
#   default     = ["FARGATE"] 
# }

# variable "memory" {
#   description = "memory"
#   type        = string
# }
# variable "cpu" {
#   description = "cpu"
#   type        = string
# }

# variable "execution_role_arn" {
#   description = "execution_role_arn"
#   type        = string
# }

# variable "container_definitions" {
#   description = "JSON-encoded container definitions for ECS task"
#   type        = string
# }

# variable "ecs_service_name" {
#   description = "ecs service name"
#   type        = string
# }
   
# variable "task_definition" {
#   description = "task definition"
#   type        = string
# }

# variable "desired_count" {
#   description = "task desired count (how many containers will run)"
#   type        = string
# }
# variable "launch_type" {
#   description = "Fargate / EC2 launch type "
#   type        = string
#   default     = "FARGATE"
# }
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





