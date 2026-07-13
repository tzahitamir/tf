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

variable "listeners_map" {
  type = map(object({
    listener_arn = string
    cert_arns    = list(string)
  }))
}