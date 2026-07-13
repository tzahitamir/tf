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

data "terraform_remote_state" "sg" {
  backend = "s3"
  config  = {
    bucket = "tzahi-temp"
    key    = "tf/ecs/1/sgprod.tfstate"
    region = "eu-west-1"
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

data "aws_security_group" "utility-prod" {
  id = "sg-0dd8059e6d1a1846b"
}

module "alb" {
  source = "../../../../modules/alb"
  albs = local.alb_definitions
  alb_listeners = local.alb_listeners
  alb_listener_rules = local.alb_listener_rules
  listeners_map = var.listeners_map
}

output "alb_arns_map" {
  value = module.alb.alb_arns_map
}

