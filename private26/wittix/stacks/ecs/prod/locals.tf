locals {

my_security_group_id = data.terraform_remote_state.sg.outputs.security_group_ids["allow-3000-prod"]
my_target_group_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["routerx-prod-tg"]

my_security_group_id2 = data.terraform_remote_state.sg.outputs.security_group_ids["alb-sg-test-tf"]
my_target_group_arn2    = data.terraform_remote_state.tg.outputs.target_group_arns_map["core-test-grpc-tg-tf"]


alb-sg-prod-tf_id = data.terraform_remote_state.sg.outputs.security_group_ids["alb-sg-prod-tf"]
core-prod-grpc-tg-tf_arn = data.terraform_remote_state.tg.outputs.target_group_arns_map["core-prod-grpc-tg-tf"]


allow-3000-internal-only_id = data.terraform_remote_state.sg.outputs.security_group_ids["allow-3000-internal-only"]
client-api-js-prod-tg_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["client-api-js-prod-tg"]

client-api-js-test-tg_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["client-api-js-test-tg"]
admin-api-js-test-tg_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["admin-api-js-test-tg"]
admin-api-js-prod-tg_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["admin-api-js-prod-tg"]


vop-test-tg_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["vop-test-tg"]
vop-prod-tg_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["vop-prod-tg"]
utility-prod-tg_arn = data.terraform_remote_state.tg.outputs.target_group_arns_map["utility-prod-tg"]
dictionary-service-tg-test_arn = data.terraform_remote_state.tg.outputs.target_group_arns_map["dictionary-service-tg-test"]

#vop-test-security_group = data.vop-test-sg.value
vop-test-sg = data.aws_security_group.vop-test.id
vop-prod-sg = data.aws_security_group.vop-prod.id
utility-prod-sg = data.aws_security_group.utility-prod.id
dictionary-service-test-sg = data.aws_security_group.dictionary-service-test-sg.id

ecs_services = {
    routerx = {
      force_new_deployment           = true
      name                           = "routerx-service-prod" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/cluster-wittix-prod"
      desired_count                  = 2
      launch_type                    = "FARGATE"
      task_definition                = "routerx-td-prod"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.private.ids
          security_groups  = [local.my_security_group_id]
          assign_public_ip = false
        }
      ]
      load_balancer = [
        {
          container_name   = "routerx"
          container_port   = 3000
          target_group_arn   = local.my_target_group_arn
        }
      ]
    },
    core-service-prod = {
      force_new_deployment           = true
      name                           = "core-service-prod" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/cluster-wittix-prod"
      desired_count                  = 0
      launch_type                    = "FARGATE"
      task_definition                = "core-td-prod"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.private.ids
          security_groups  = [local.my_security_group_id]
          assign_public_ip = false
        }
      ]
      load_balancer = []
    },
    # core-service-dev = {
    #   force_new_deployment           = true
    #   name                           = "core-service-dev" 
    #   cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/centro-test"
    #   desired_count                  = 2
    #   launch_type                    = "FARGATE"
    #   task_definition                = "core-td-dev"
    #   availability_zone_rebalancing = "ENABLED"
    #   network_configuration = [
    #     {
    #       subnets          = data.aws_subnets.private.ids
    #       security_groups  = [local.my_security_group_id]
    #       assign_public_ip = false
    #     }
    #   ]
    #   load_balancer = []
    # },
    core-service-dev-tf = {
      force_new_deployment           = true
      name                           = "core-service-dev-tf" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/centro-test"
      desired_count                  = 2
      launch_type                    = "FARGATE"
      task_definition                = "core-td-dev-tf"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.private.ids
          security_groups  = [local.my_security_group_id2]
          assign_public_ip = false
        }
      ]
      load_balancer = [
        {
          container_name   = "core-test"
          container_port   = 50051
          target_group_arn   = local.my_target_group_arn2
        }
      ]
    },
    core-service-prod-tf = {
      force_new_deployment           = true
      name                           = "core-service-prod-tf" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/cluster-wittix-prod"
      desired_count                  = 2
      launch_type                    = "FARGATE"
      task_definition                = "core-td-prod-tf"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.private.ids
          security_groups  = [local.alb-sg-prod-tf_id]
          assign_public_ip = false
        }
      ]
      load_balancer = [
        {
          container_name   = "core"
          container_port   = 50051
          target_group_arn   = local.core-prod-grpc-tg-tf_arn
        }
      ]
    },
    client-api-js-prod = {
      force_new_deployment           = true
      name                           = "client-api-js-prod" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/cluster-wittix-prod"
      desired_count                  = 2
      launch_type                    = "FARGATE"
      task_definition                = "client-api-js-prod-td-tf"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.private.ids
          security_groups  = [local.allow-3000-internal-only_id]
          assign_public_ip = false
        }
      ]
      load_balancer = [
        {
          container_name   = "client-api-js-prod"
          container_port   = 3000
          target_group_arn   = local.client-api-js-prod-tg_arn
        }
      ]
    },
    client-api-js-test = {
      force_new_deployment           = true
      name                           = "client-api-js-test" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/centro-test"
      desired_count                  = 2
      launch_type                    = "FARGATE"
      task_definition                = "client-api-js-test-td-tf"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.private.ids
          security_groups  = [local.allow-3000-internal-only_id]
          assign_public_ip = false
        }
      ]
      load_balancer = [
        {
          container_name   = "client-api-js-test"
          container_port   = 3000
          target_group_arn   = local.client-api-js-test-tg_arn
        }
      ]
    },
    admin-api-js-test = {
      force_new_deployment           = true
      name                           = "admin-api-js-test" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/centro-test"
      desired_count                  = 2
      launch_type                    = "FARGATE"
      task_definition                = "admin-api-js-test-td-tf"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.private.ids
          security_groups  = [local.allow-3000-internal-only_id]
          assign_public_ip = false
        }
      ]
      load_balancer = [
        {
          container_name   = "admin-api-js-test"
          container_port   = 3000
          target_group_arn   = local.admin-api-js-test-tg_arn
        }
      ]
    },
    admin-api-js-prod = {
      force_new_deployment           = true
      name                           = "admin-api-js-prod" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/cluster-wittix-prod"
      desired_count                  = 2
      launch_type                    = "FARGATE"
      task_definition                = "admin-api-js-prod-td-tf"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.private.ids
          security_groups  = [local.allow-3000-internal-only_id]
          assign_public_ip = false
        }
      ]
      load_balancer = [
        {
          container_name   = "admin-api-js-prod"
          container_port   = 3000
          target_group_arn   = local.admin-api-js-prod-tg_arn
        }
      ]
    },
    vop-test-tf = {
      force_new_deployment           = true
      name                           = "vop-test-tf" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/centro-test"
      desired_count                  = 2
      launch_type                    = "FARGATE"
      task_definition                = "vop-test-td-tf"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.private.ids
          security_groups  = [local.vop-test-sg]
          #security_groups  = [local.allow-3000-internal-only_id]
          assign_public_ip = false
        }
      ]
      load_balancer = [
        {
          container_name   = "vop-test"
          container_port   = 3333
          target_group_arn   = local.vop-test-tg_arn 
        }
      ]
    },

####
vop-prod-tf = {
      force_new_deployment           = true
      name                           = "vop-prod-tf" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/cluster-wittix-prod"
      desired_count                  = 2
      launch_type                    = "FARGATE"
      task_definition                = "vop-prod-td-tf"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.private.ids
          security_groups  = [local.vop-prod-sg]
          #security_groups  = [local.allow-3000-internal-only_id]
          assign_public_ip = false
        }
      ]
      load_balancer = [
        {
          container_name   = "vop-prod"
          container_port   = 3334
          target_group_arn   = local.vop-prod-tg_arn 
        }
      ]
    },
####
utility-prod-tf = {
      force_new_deployment           = true
      name                           = "utility-prod" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/cluster-wittix-prod"
      desired_count                  = 2
      launch_type                    = "FARGATE"
      task_definition                = "utility-prod-td-tf"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.private.ids
          security_groups  = [local.utility-prod-sg]
          assign_public_ip = false
        }
      ]
      load_balancer = [
        {
          container_name   = "utility-prod"
          container_port   = 3335
          target_group_arn   = local.utility-prod-tg_arn 
        }
      ]
    },
##### 
dictionary-service-test-tf = {
      force_new_deployment           = true
      name                           = "dictionary-service-test-tf" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/centro-test"
      desired_count                  = 2
      launch_type                    = "FARGATE"
      task_definition                = "dictionary-service-test-td-tf"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.private.ids
          security_groups  = [local.dictionary-service-test-sg]
          assign_public_ip = false
        }
      ]
      load_balancer = [
        {
          container_name   = "dictionary-service-test"
          container_port   = 3337
          target_group_arn   = local.dictionary-service-tg-test_arn 
        }
      ]
    }   
  }
}
