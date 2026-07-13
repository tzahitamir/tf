locals {

my_security_group_id = data.terraform_remote_state.sg.outputs.security_group_ids["web-sg-allow-443-test"]
my_target_group_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["alb-443-tg-test"]
my_target_group_arn2    = data.terraform_remote_state.tg.outputs.target_group_arns_map["alb-8000-tg-test"]
my_security_group_id2 = data.terraform_remote_state.sg.outputs.security_group_ids["allow-8000-tf-test"]


alb_definitions = {
  "test-alb-external" = {
      name               = "test-alb-external"
      internal           = false
      load_balancer_type = "application"
      subnets            = data.aws_subnets.public.ids
      security_groups    = [local.my_security_group_id]
      enable_deletion_protection = false
      tags = {
        Env = "test"
      }
    },
    "test-alb-internal" = {
      name               = "test-alb-internal"
      internal           = true
      load_balancer_type = "application"
      subnets            = data.aws_subnets.private.ids
      security_groups    = [local.my_security_group_id2]
      #Turn to true for prod#
      enable_deletion_protection = false
      tags = {
        Env = "test"
      }
    }
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
         #target_group_arn = module.tg.target_group_arns["service2-tg-test"]
          target_group_arn   = local.my_target_group_arn
        }
      ]
    },
    "listen8000" = {
      port     = 8000
      protocol = "HTTP"
      # ssl_policy = "ELBSecurityPolicy-2016-08"
      # certificate_arn = data.aws_acm_certificate.wittixme_cert.arn 
      #certificate_arn = data.aws_acm_certificate.wittixcom_cert.arn 
      load_balancer_arn = module.alb.alb_arns_map["test-alb-internal"]
      default_action = [
        {
          type             = "forward"
          target_group_arn   = local.my_target_group_arn2
        }
      ]
    }
  }
}