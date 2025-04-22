
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





#module "sg" {
#  for_each = var.security_groups

#  source        = "../modules/sg"
#  name          = each.value.name
#  description   = each.value.description
#  vpc_id        = var.vpc_id
#  ingress_rules = each.value.ingress_rules
#  egress_rules  = each.value.egress_rules
#  tags          = each.value.tags
#}


#need to change module ecs to for_each approach, currentlly support create of only 1 ecs 
#module "ecs" {
#  source = "../modules/ecs"
#  ecs_cluster_name = var.ecs_cluster_name
#  family                  = var.family
#  memory                  = var.memory
#  cpu                     = var.cpu
#  execution_role_arn      = var.execution_role_arn
#  requires_compatibilities = var.requires_compatibilities
#  container_definitions   = var.container_definitions
#  ecs_service_name = var.ecs_service_name
#  task_definition = var.task_definition
#  desired_count = var.desired_count
#  launch_type = var.launch_type
#}

