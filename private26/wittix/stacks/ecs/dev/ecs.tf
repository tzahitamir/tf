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

data "terraform_remote_state" "tg" {
  backend = "s3"
  config  = {
    bucket = "tzahi-temp"
    key    = "tf/ecs/1/tgdev.tfstate"
    region = "eu-west-1"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"
  config  = {
    bucket = "tzahi-temp"
    key    = "tf/ecs/1/sgdev.tfstate"
    region = "eu-west-1"
  }
}


module "ecs" {
  source = "../../../../modules/ecs"
  ecs_clusters = var.ecs_clusters
  aws_ecs_task_definition = var.aws_ecs_task_definition
  aws_cloudwatch_log_group = var.aws_cloudwatch_log_group
  aws_ecs_service_definition = local.ecs_services
  # depends_on = [
  #   module.listeners
  # ]
}