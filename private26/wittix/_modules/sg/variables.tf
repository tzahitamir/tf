variable "name" {
  description = "Security Group Name"
  type        = string
}

variable "description" {
  description = "Security Group Description"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the Security Group"
  type        = string
}

variable "ingress_rules" {
  description = "Ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string), []) # Default to empty list
    self        = optional(bool, false)      # Default to false
  }))
}

variable "egress_rules" {
  description = "Egress rules"
  type = list(object({
    from_port   = optional(number) 
    to_port     = optional(number) 
    protocol    = optional(string) 
    cidr_blocks = list(string)
  }))
}

variable "tags" {
  description = "Tags for the Security Group"
  type        = map(string)
}
