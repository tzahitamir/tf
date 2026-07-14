# data "aws_vpc" "existing_vpc" {
#   filter {
#     name   = "tag:Name"
#     values = ["wittix"]
#   }
# }

# data "aws_subnets" "public" {
#   filter {
#     name   = "tag:public"
#     values = ["true"]
#   }
# }

# data "aws_subnets" "private" {
#   filter {
#     name   = "tag:private"
#     values = ["true"]
#   }
# }


module "sg" {
  source          = "../../../../modules/sg"
  vpc_id          = var.vpc_id
  security_groups = var.security_groups
}


output "security_group_ids" {
  value = module.sg.security_group_ids
}
