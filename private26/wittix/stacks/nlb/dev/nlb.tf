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


module "nlb" {
  source = "../../../../modules/nlb"
  nlbs = local.nlb_definitions
  #  depends_on = [
  #   module.tg
  # ]
}

output "nlb_arns_map" {
  value = module.nlb.nlb_arns_map
}
