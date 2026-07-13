
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
    ssl_policy                 = string
    certificate_arn            = string
    default_action             = list(object({
      type             = string
      target_group_arn = string
    }))}))
}










