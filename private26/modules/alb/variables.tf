
variable "albs" {
  description = "Application Load Balancer"
  type                       = map(object({
    name                       = string
    internal                   = bool
    load_balancer_type         = string
    subnets                    = list(string)
    security_groups            = list(string) 
    enable_deletion_protection = bool
    tags                       = map(string)
  }))
}

variable "alb_listeners" {
  description = "ALB Listeners"
  type                       = map(object({
    load_balancer_arn         = string
    port                       = number
    protocol                   = string
    ssl_policy                 = optional(string)
    certificate_arn            = optional(string)
    default_action             = list(object({
      type             = string
      target_group_arn = string
    }))}))
}

variable "alb_listener_rules" {
  description = "ALB Listener Rules"
  type = map(object({
    listener_arn = string
    priority     = number
    action       = list(object({
      type             = string
      target_group_arn = string
    }))
    condition = object({
      host_header = object({
        values = list(string)
      })
    })
  }))
  default = {}
}

variable "listeners_map" {
  type = map(object({
    listener_arn = string
    cert_arns    = list(string)
  }))
}







