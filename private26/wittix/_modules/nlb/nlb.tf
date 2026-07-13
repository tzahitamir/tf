
resource "aws_lb" "nlbs" {
  for_each = var.nlbs

  name                        = each.value.name
  internal                    = each.value.internal
  load_balancer_type          = each.value.load_balancer_type
  subnets                     = each.value.subnets
  enable_deletion_protection  = each.value.enable_deletion_protection
  tags                        = each.value.tags
}

# resource "aws_lb_target_group" "tgs" {
#   for_each = var.tgs

#   name        = each.value.name
#   port        = each.value.port
#   protocol    = each.value.protocol
#   target_type = each.value.target_type
#   vpc_id      = each.value.vpc_id
# }



