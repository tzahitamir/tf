
variable "nlb_listeners" {
  description = "Listeners"
  type        = map(object({
    load_balancer_arn  = string
    port               = number
    protocol           = string
    default_action    = list(object({
      type             = string
      target_group_arn = string
    }))
    
  }))
}



