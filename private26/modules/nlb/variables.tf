
variable "nlbs" {
  description = "Network Load Balancer"
  type        = map(object({
    name               = string
    internal           = bool
    load_balancer_type = string
    subnets            = list(string)
    enable_deletion_protection = bool
    tags               = map(string)
  }))
}



# variable "tgs" {
#   description = "Target groups"
#   type        = map(object({
#     name               = string
#     port               = number
#     protocol           = string
#     target_type        = string
#     vpc_id             = string
#   }))
# }





