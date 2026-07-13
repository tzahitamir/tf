
variable "tgs" {
  description = "Target groups"
  type        = map(object({
    name               = string
    port               = number
    protocol           = string
    protocol_version   = optional(string) # Only for gRPC, default is HTTP
    target_type        = string
    vpc_id             = string
    stickiness        = optional(object({
      type            = optional(string) # Only "lb_cookie" is supported for ALB
      enabled         = optional(bool, false)
      cookie_duration = optional(number, 86400) # in seconds (optional, default: 1 day)
    }))
  }))
}
# stickiness {
#     type            = "lb_cookie"   # Only "lb_cookie" is supported for ALB
#     enabled         = true
#     cookie_duration = 86400         # in seconds (optional, default: 1 day)
#   }
# }




