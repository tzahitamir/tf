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
 for_each = var.security_groups

 source        = "../../../../modules/sg"
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
