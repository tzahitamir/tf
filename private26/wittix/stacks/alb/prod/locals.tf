locals {

#my_security_group_id = data.terraform_remote_state.sg.outputs.security_group_ids["allow-443-prod"]
my_security_group_id = data.terraform_remote_state.sg.outputs.security_group_ids["allow-443-cf"]
my_target_group_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["routerx-prod-tg"]

my_security_group_id2 = data.terraform_remote_state.sg.outputs.security_group_ids["alb-sg-test-tf"]
my_target_group_arn2    = data.terraform_remote_state.tg.outputs.target_group_arns_map["core-test-grpc-tg-tf"]

alb_sg_prod_tf_id = data.terraform_remote_state.sg.outputs.security_group_ids["alb-sg-prod-tf"]
core_prod_grpc_target_group_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["core-prod-grpc-tg-tf"]

client-api-js-test-tg_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["client-api-js-test-tg"]
client-api-js-prod-tg_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["client-api-js-prod-tg"]
admin-api-js-prod-tg_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["admin-api-js-prod-tg"]

admin-api-js-test-tg_arn = data.terraform_remote_state.tg.outputs.target_group_arns_map["admin-api-js-test-tg"]
vop-prod-tg-arn = data.terraform_remote_state.tg.outputs.target_group_arns_map["vop-prod-tg"]
vop-test-tg-arn = data.terraform_remote_state.tg.outputs.target_group_arns_map["vop-test-tg"]
utility-prod-tg-arn = data.terraform_remote_state.tg.outputs.target_group_arns_map["utility-prod-tg"]
dictionary-service-tg-prod_arn = data.terraform_remote_state.tg.outputs.target_group_arns_map["dictionary-service-tg-test"]


###########
alb_definitions = {
  "alb-external-prod" = {
      name               = "alb-external-prod"
      internal           = false
      load_balancer_type = "application"
      subnets            = data.aws_subnets.public.ids
      security_groups    = [local.my_security_group_id]
      enable_deletion_protection = false
      tags = {
        env = "prod"
        terraform = "true"
      }
    },
    "alb-external-test-tf" = {
      name               = "alb-external-test-tf"
      internal           = false
      load_balancer_type = "application"
      subnets            = data.aws_subnets.public.ids
      security_groups    = [local.my_security_group_id2]
      enable_deletion_protection = false
      tags = {
        env = "test"
        terraform = "true"
      }
    },
    "alb-ext-prod-office-only" = {
      name               = "alb-ext-prod-office-only"
      internal           = false
      load_balancer_type = "application"
      subnets            = data.aws_subnets.public.ids
      security_groups    = [local.alb_sg_prod_tf_id]
      enable_deletion_protection = false
      tags = {
        env = "prod"
        terraform = "true"
      }
    },
    "alb-ext-test-public-full-tf" = {
      name               = "alb-ext-test-public-full-tf"
      internal           = false
      load_balancer_type = "application"
      subnets            = data.aws_subnets.public.ids
      security_groups    = [local.my_security_group_id]
      enable_deletion_protection = false
      tags = {
        env = "test"
        terraform = "true"
      }
    }
}
######

alb_listeners = {
    "listen443" = {
      port     = 443
      protocol = "HTTPS"
      ssl_policy = "ELBSecurityPolicy-2016-08"
      #certificate_arn = data.aws_acm_certificate.wittixme_cert.arn 
      certificate_arn = data.aws_acm_certificate.wittixcom_cert.arn 
      load_balancer_arn = module.alb.alb_arns_map["alb-external-prod"]
      default_action = [
        {
          type             = "forward"
          target_group_arn   = local.my_target_group_arn
        }
      ]
    },
    "listen443-test" = {
      port     = 443
      protocol = "HTTPS"
      ssl_policy = "ELBSecurityPolicy-2016-08"
      load_balancer_arn = module.alb.alb_arns_map["alb-external-test-tf"]
      certificate_arn = data.aws_acm_certificate.wittixme_cert.arn
      default_action = [
        {
          type             = "forward"
          target_group_arn   = local.my_target_group_arn2
        }
      ]
    },
    "listen443-office-only" = {
      port     = 443
      protocol = "HTTPS"
      ssl_policy = "ELBSecurityPolicy-2016-08"
      load_balancer_arn = module.alb.alb_arns_map["alb-ext-prod-office-only"]
      certificate_arn = data.aws_acm_certificate.wittixme_cert.arn
      default_action = [
        {
          type             = "forward"
          target_group_arn   = local.core_prod_grpc_target_group_arn
        }
      ]
    },
    "listen443-alb-ext-test-public-full-tf" = {
      port     = 443
      protocol = "HTTPS"
      ssl_policy = "ELBSecurityPolicy-2016-08"
      certificate_arn = data.aws_acm_certificate.wittixme_cert.arn 
      #certificate_arn = data.aws_acm_certificate.wittixcom_cert.arn 
      load_balancer_arn = module.alb.alb_arns_map["alb-ext-test-public-full-tf"]
      default_action = [
        {
          type             = "forward"
          target_group_arn   = local.client-api-js-test-tg_arn
        }
      ]
    },

    
    
  }
###########
alb_listener_rules = {
  core_test_rule = {
    listener_arn = module.alb.aws_lb_listener_arns_map["listen443-test"]
    priority     = 10
    action = [
      {
        type             = "forward"
        target_group_arn = local.my_target_group_arn2
      }
    ]
    condition = {
      host_header = {
        values = ["core.wittix.me"]
      }
    }
  },
  client-api-js-test-rule = {
    listener_arn = module.alb.aws_lb_listener_arns_map["listen443-alb-ext-test-public-full-tf"]
    priority     = 10
    action = [
      {
        type             = "forward"
        target_group_arn = local.client-api-js-test-tg_arn
      }
    ]
    condition = {
      host_header = {
        values = ["client-api.wittix.me"]
      }
    }
  },
  client-api-js-prod-rule = {
    listener_arn = module.alb.aws_lb_listener_arns_map["listen443"]
    priority     = 10
    action = [
      {
        type             = "forward"
        target_group_arn = local.client-api-js-prod-tg_arn
      }
    ]
    condition = {
      host_header = {
        values = ["client-api.wittix.com"]
      }
    }
  },
  admin-api-js-test-rule = {
    listener_arn = module.alb.aws_lb_listener_arns_map["listen443-alb-ext-test-public-full-tf"]
    priority     = 20
    action = [
      {
        type             = "forward"
        target_group_arn = local.admin-api-js-test-tg_arn
      }
    ]
    condition = {
      host_header = {
        values = ["admin-api.wittix.me"]
      }
    }
  },
  utility-rule = {
    listener_arn = module.alb.aws_lb_listener_arns_map["listen443-office-only"]
    priority     = 20
    action = [
      {
        type             = "forward"
        target_group_arn = local.utility-prod-tg-arn
      }
    ]
    condition = {
      host_header = {
        values = ["utility.wittix.me"]
      }
    }
  },
  admin-api-js-prod-rule = {
    listener_arn = module.alb.aws_lb_listener_arns_map["listen443-office-only"]
    priority     = 30
    action = [
      {
        type             = "forward"
        target_group_arn = local.admin-api-js-prod-tg_arn
      }
    ]
    condition = {
      host_header = {
        values = ["api.mywalletcrm.com"]
      }
    }
  },
  dictionary-service-test-rule = {
    listener_arn = module.alb.aws_lb_listener_arns_map["listen443-office-only"]
    priority     = 40
    action = [
      {
        type             = "forward"
        target_group_arn = local.dictionary-service-tg-prod_arn
      }
    ]
    condition = {
      host_header = {
        values = ["dictionary.wittix.me"]
      }
    }
  }
}
###########
}