
####
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
}









