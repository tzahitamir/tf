locals {

my_security_group_id = data.terraform_remote_state.sg.outputs.security_group_ids["allow-8000-tf-test"]
my_target_group_arn    = data.terraform_remote_state.tg.outputs.target_group_arns_map["alb-8000-tg-test"]

ecs_services = {
    service1 = {
      force_new_deployment           = true
      name                           = "tf-service1-test" 
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/cluster-tf-test"
      desired_count                  = 1
      launch_type                    = "FARGATE"
      task_definition                = "tf-test"
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
          #target_group_arn = module.tg.target_group_arns["service1-tg-test"]
          target_group_arn   = local.my_target_group_arn
        }
      ]
    },
    service2 = {
      force_new_deployment           = true
      name                           = "tf-service1-test77"
      cluster                        = "arn:aws:ecs:eu-west-1:455178800756:cluster/cluster-tf-test"
      desired_count                  = 5
      launch_type                    = "FARGATE"
      task_definition                = "td-test77"
      availability_zone_rebalancing = "ENABLED"
      network_configuration = [
        {
          subnets          = data.aws_subnets.public.ids
          security_groups  = [local.my_security_group_id]
          assign_public_ip = true
        }
      ]
        load_balancer = []
      # load_balancer = [
      #   {
      #     container_name   = "sample-app"
      #     container_port   = 8000
      #     target_group_arn = module.tg.target_group_arns["service2-tg-test"]
      #   }
      # ]
    }
  }

}