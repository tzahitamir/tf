locals {

vpc_id = data.aws_vpc.existing_vpc.id

tg_definitions = {
   # NLB Target Groups
    "service1-tg-test" = {
      name        = "service1-tg-test"
      port        = 80
      protocol    = "TCP"
      target_type = "ip"
      vpc_id      = var.vpc_id
      tag_specifications = [
        {
          resource_type = "target-group"
          tags = {
            Name        = "service1-tg-test"
            Environment = "test"
          }
        }
      ]
     }

     #ALB Target Groups
    # "service2-tg-test" = {
    #   name        = "service2-tg-test"
    #   port        = 2222
    #   protocol    = "HTTP"
    #   target_type = "ip"
    #   vpc_id      = var.vpc_id
    #   stickiness = {
    #     type            = "lb_cookie"   # Only "lb_cookie" is supported for ALB
    #     enabled         = true
    #     cookie_duration = 86400         # in seconds (optional, default: 1 day)
    #   }
    #     tag_specifications = [
    #         {
    #         resource_type = "target-group"
    #         tags = {
    #             Name        = "service2-tg-test"
    #             Environment = "test"
    #         }
    #         }
    #     ]
    # }

    "alb-443-tg-test" = {
      name        = "alb-443-tg-test"
      port        = 443
      protocol    = "HTTPS"
      target_type = "ip"
      vpc_id      = var.vpc_id
      stickiness = {
        type            = "lb_cookie"   # Only "lb_cookie" is supported for ALB
        enabled         = true
        cookie_duration = 86400         # in seconds (optional, default: 1 day)
      }
        tag_specifications = [
            {
            resource_type = "target-group"
            tags = {
                Name        = "alb-443-tg-test"
                Environment = "test"
            }
            }
        ]
    }
  "alb-8000-tg-test" = {
      name        = "alb-8000-tg-test"
      port        = 8000
      protocol    = "HTTP"
      target_type = "ip"
      vpc_id      = var.vpc_id
      stickiness = {
        type            = "lb_cookie"   # Only "lb_cookie" is supported for ALB
        enabled         = true
        cookie_duration = 86400         # in seconds (optional, default: 1 day)
      }
        tag_specifications = [
            {
            resource_type = "target-group"
            tags = {
                Name        = "alb-8000-tg-test"
                Environment = "test"
            }
            }
        ]
    }
  }
}