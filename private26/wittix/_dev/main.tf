data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = ["wittix"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:public"
    values = ["true"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:private"
    values = ["true"]
  }
}
data "aws_acm_certificate" "wittixcom_cert" {
  domain   = "*.wittix.com"
  statuses = ["ISSUED"]
}

data "aws_acm_certificate" "wittixme_cert" {
  domain   = "*.wittix.me"
  statuses = ["ISSUED"]
}

output "wittix_com_cert_arn" {
  value = data.aws_acm_certificate.wittixcom_cert.arn
} 
output "wittix_me_cert_arn" {
  value = data.aws_acm_certificate.wittixme_cert.arn
}
####################################

module "sg" {
 for_each = var.security_groups

 source        = "../modules/sg"
 name          = each.value.name
 description   = each.value.description
 vpc_id        = var.vpc_id
 ingress_rules = each.value.ingress_rules
 egress_rules  = each.value.egress_rules
 tags          = each.value.tags
}


output "security_group_ids" {
  value = {
    for sg_key, sg_module in module.sg :
    sg_key => sg_module.security_group_id
  } 
}

#######
module "iam_policies" {
  source = "../modules/iam_policies"
  iam_policies = var.iam_policies
}
output "policy_arns_map" {
  value = module.iam_policies.iam_policy_arns
}

module "iam_roles" {
  source = "../modules/iam_roles"
  iam_roles = var.iam_roles
}

module "iam_policy_attach" {
  source = "../modules/iam_policy_attach"
  role_policy_map = var.role_policy_map
  policy_arns = module.iam_policies.iam_policy_arns
}
#####
module "tg" {
  source = "../modules/tg"
  tgs = local.tg_definitions
}

output "target_group_arns_map" {
  value = module.tg.target_group_arns
}

#####
module "nlb" {
  source = "../modules/nlb"
  nlbs = local.nlb_definitions
   depends_on = [
    module.tg
  ]
}

output "nlb_arns_map" {
  value = module.nlb.nlb_arns_map
}

#####
module "alb" {
  source = "../modules/alb"
  albs = local.alb_definitions
  alb_listeners = local.alb_listeners
  depends_on = [
    module.tg
  ]
}

output "alb_arns_map" {
  value = module.alb.alb_arns_map
}

module "alb_listener_rules" {
  source = "../modules/alb_listener_rule"
  alb_listener_rules = local.alb_listener_rules
  depends_on = [
    module.alb
  ] 
}
#####
module "listeners" {
  source = "../modules/listeners"
  nlb_listeners = local.listeners
  depends_on = [
    module.nlb
  ]
}
#####
module "ecs" {
  source = "../modules/ecs"
  ecs_clusters = var.ecs_clusters
  aws_ecs_task_definition = var.aws_ecs_task_definition
  aws_cloudwatch_log_group = var.aws_cloudwatch_log_group
  aws_ecs_service_definition = local.ecs_services
  depends_on = [
    module.listeners
  ]
}


