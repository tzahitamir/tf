locals {

  my_security_group_id = module.sg["allow-8000"].security_group_id
  external_security_group_id = module.sg["web-sg-test1"].security_group_id

#################################################

  ecs_services = {
    service1 = {
      force_new_deployment           = true
      name                           = "service1" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/cluster-prod-test"
      desired_count                  = 1
      launch_type                    = "FARGATE"
      task_definition                = "td-test1"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.private.ids
          security_groups  = [local.my_security_group_id]
          #assign_public_ip = true
          assign_public_ip = false
        }
      ]
      load_balancer = [
        {
          container_name   = "sample-app"
          container_port   = 8000
          target_group_arn = module.tg.target_group_arns["service1-tg-test"]
        }
      ]
    },
    service2 = {
      force_new_deployment           = true
      name                           = "service2"
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/cluster-prod-test"
      desired_count                  = 1
      launch_type                    = "FARGATE"
      task_definition                = "td-test2"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.public.ids
          security_groups  = [local.my_security_group_id]
          assign_public_ip = true
        }
      ]
      load_balancer = [
        {
          container_name   = "sample-app"
          container_port   = 8000
          target_group_arn = module.tg.target_group_arns["service2-tg-test"]
        }
      ]
    }
  }
#################################################



alb_definitions = {
  "test-alb-external" = {
      name               = "test-alb-external"
      internal           = false
      load_balancer_type = "application"
      subnets            = data.aws_subnets.public.ids
      security_groups    = [local.external_security_group_id]
      #Turn to true for prod#
      enable_deletion_protection = false
      tags = {
        Env = "prod"
      }
    }#,
}
alb_listeners = {
    "listen443" = {
      port     = 443
      protocol = "HTTPS"
      ssl_policy = "ELBSecurityPolicy-2016-08"
      certificate_arn = data.aws_acm_certificate.wittixme_cert.arn 
      #certificate_arn = data.aws_acm_certificate.wittixcom_cert.arn 
      load_balancer_arn = module.alb.alb_arns_map["test-alb-external"]
      default_action = [
        {
          type             = "forward"
          target_group_arn = module.tg.target_group_arns["service2-tg-test"]
        }
      ]
    }
  }

alb_listener_rules = {
    "rule1" = {
      listener_arn = module.alb.aws_lb_listener_arns_map["listen443"]
      priority     = 100
      action = [
        {
          type             = "forward"
          target_group_arn = module.tg.target_group_arns["service2-tg-test"]
          stickiness = {
            enabled  = true
            duration = 600
          }
        }
      ]
          condition = {
            host_header = {
              values = ["sample-app.wittix.me"]
            }
          }
      }
  }

##################################################
 
 nlb_definitions = {
    "test-nlb-internal" = {
      name               = "test-nlb-internal"
      #internal           = false
      internal           = true
      load_balancer_type = "network"
      subnets            = data.aws_subnets.private.ids
      #Turn to true for prod#
      enable_deletion_protection = false
      tags = {
        Env = "prod"
      }
    }#,
    # "internal-test-nlb" = {
    #   name               = "admin-nlb"
    #   internal           = true
    #   load_balancer_type = "network"
    #   subnets            = data.aws_subnets.private.ids
    #   #Turn to true for prod#
    #   enable_deletion_protection = false
    #   tags = {
    #     Env = "prod"
    #   }
    # }
 }

#NLB Listeners
   listeners = {
    service1 = {
      port     = 80
      protocol = "TCP"
      load_balancer_arn = module.nlb.nlb_arns_map["test-nlb-internal"]
      default_action = [
        {
          type             = "forward"
          target_group_arn = module.tg.target_group_arns["service1-tg-test"]
        }
      ]
    }
    
    # service2 = {
    #   port     = 90
    #   protocol = "TCP"
    #   load_balancer_arn = module.nlb.nlb_arns_map["public-test-nlb"]
    #   default_action = [
    #     {
    #       type             = "forward"
    #       target_group_arn = module.nlb.target_group_arns["service2-tg-test"]
    #     }
    #   ]
    # }
  }
#################################################

  tg_definitions = {
    #NLB Target Groups
    "service1-tg-test" = {
      name        = "service1-tg-test"
      port        = 8000
      protocol    = "TCP"
      target_type = "ip"
      vpc_id      = var.vpc_id
     }
     #ALB Target Groups
    "service2-tg-test" = {
      name        = "service2-tg-test"
      port        = 8000
      protocol    = "HTTP"
      target_type = "ip"
      vpc_id      = var.vpc_id
      stickiness = {
        type            = "lb_cookie"   # Only "lb_cookie" is supported for ALB
        enabled         = true
        cookie_duration = 86400         # in seconds (optional, default: 1 day)
      }
    }
    # service1-tg-test-new = {
    #   name        = "service1-tg-test-new"
    #   port        = 8000
    #   protocol    = "TCP"
    #   target_type = "ip"
    #   vpc_id      = var.vpc_id
    # }
  }
#################################################

}
