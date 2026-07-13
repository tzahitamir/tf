locals {

vpc_id = data.aws_vpc.existing_vpc.id

tg_definitions = {
   
  "routerx-prod-tg" = {
      name        = "routerx-prod-tg"
      port        = 3000
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
                Name        = "routerx-prod-tg"
                Environment = "prod"
                terraform   = "true"
            }
            }
        ]
    },
    "core-prod-grpc-tg" = {
      name        = "core-prod-grpc-tg"
      port        = 50051
      protocol    = "HTTP"
      protocol_version = "GRPC" 
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
                Name        = "core-prod-grpc-tg"
                Environment = "prod"
                terraform   = "true"
            }
            }
        ]
    },
    "core-test-grpc-tg-tf" = {
      name        = "core-test-grpc-tg-tf"
      port        = 50051
      protocol    = "HTTP"
      protocol_version = "GRPC" 
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
                Name        = "core-test-grpc-tg-tf"
                Environment = "test"
                terraform   = "true"
            }
            }
        ]
    },
    "core-prod-grpc-tg-tf" = {
      name        = "core-prod-grpc-tg-tf"
      port        = 50051
      protocol    = "HTTP"
      protocol_version = "GRPC" 
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
                Name        = "core-prod-grpc-tg-tf"
                Environment = "prod"
                terraform   = "true"
            }
            }
        ]
    },
  "client-api-js-test-tg" = {
      name        = "client-api-js-test-tg"
      port        = 3000
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
                Name        = "client-api-js-test-tg"
                Environment = "test"
                terraform   = "true"
            }
            }
        ]
    },
  "client-api-js-prod-tg" = {
      name        = "client-api-js-prod-tg"
      port        = 3000
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
                Name        = "client-api-js-prod-tg"
                Environment = "prod"
                terraform   = "true"
            }
            }
        ]
    },
    "admin-api-js-test-tg" = {
      name        = "admin-api-js-test-tg"
      port        = 3000
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
                Name        = "admin-api-js-test-tg"
                Environment = "test"
                terraform   = "true"
            }
            }
        ]
    },
    "admin-api-js-prod-tg" = {
      name        = "admin-api-js-prod-tg"
      port        = 3000
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
                Name        = "admin-api-js-prod-tg"
                Environment = "prod"
                terraform   = "true"
            }
            }
        ]
    },
    "vop-test-tg" = {
      name        = "vop-test-tg"
      port        = 3333
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
                Name        = "vop-test-tg"
                Environment = "test"
                terraform   = "true"
            }
            }
        ]
    },
    ########################
    "vop-prod-tg" = {
      name        = "vop-prod-tg"
      port        = 3334
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
                Name        = "vop-prod-tg"
                Environment = "prod"
                terraform   = "true"
            }
            }
        ]
    },
#########################   
"utility-prod-tg" = {
      name        = "utility-prod-tg"
      port        = 3335
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
                Name        = "utility-prod-tg"
                Environment = "prod"
                terraform   = "true"
            }
            }
        ]
    }
####################
 "admin-api-js-tg" = {
      name        = "admin-api-js-tg"
      port        = 3336
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
                Name        = "admin-api-js-tg"
                Environment = "test"
                terraform   = "true"
            }
            }
        ]
    },
   "dictionary-service-tg-test" = {
      name        = "dictionary-service-tg-test"
      port        = 3337
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
                Name        = "dictionary-service-tg-test"
                Environment = "test"
                terraform   = "true"
            }
            }
        ]
    }, 
    "dictionary-service-tg-prod" = {
      name        = "dictionary-service-tg-prod"
      port        = 3338
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
                Name        = "dictionary-service-tg-prod"
                Environment = "prod"
                terraform   = "true"
            }
            }
        ]
    }
#######
  }
}