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
    key    = "tf/ecs/1/tgprod.tfstate"
    region = "eu-west-1"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"
  config  = {
    bucket = "tzahi-temp"
    key    = "tf/ecs/1/sgprod.tfstate"
    region = "eu-west-1"
  }
}

data "aws_security_group" "vop-test" {
  id = "sg-0198ae779046d367b"
}

data "aws_security_group" "vop-prod" {
  id = "sg-0bc4bb1b0b7f276dd"
}
data "aws_security_group" "utility-prod" {
  id = "sg-0dd8059e6d1a1846b"
}
data "aws_security_group" "dictionary-service-test-sg" {
  id = "sg-0515024a8a58e2bc5"
}

module "ecs" {
  source = "../../../../modules/ecs"
  ecs_clusters = var.ecs_clusters
  aws_ecs_task_definition = var.aws_ecs_task_definition
  aws_cloudwatch_log_group = var.aws_cloudwatch_log_group
  aws_ecs_service_definition = local.ecs_services
}