data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = ["wittix"]
  }
}


module "tg" {
  source = "../../../../modules/tg"
  tgs = local.tg_definitions
}


output "target_group_arns_map" {
  value = module.tg.target_group_arns
}

