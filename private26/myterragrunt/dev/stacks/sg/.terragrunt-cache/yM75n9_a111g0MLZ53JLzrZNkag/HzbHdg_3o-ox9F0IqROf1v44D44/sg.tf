resource "aws_security_group" "sg" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol     
      cidr_blocks = ingress.value.cidr_blocks
      self        = ingress.value.self 
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = var.tags
}
# # For SG-based ingress rules
# resource "aws_security_group_rule" "sg_ingress" {
#   for_each                 = { for rule in var.ingress_rules : rule.key => rule if contains(keys(rule), "source_security_group_id") }
#   type                     = "ingress"
#   from_port                = each.value.from_port
#   to_port                  = each.value.to_port
#   protocol                 = each.value.protocol
#   security_group_id        = aws_security_group.sg.id
#   source_security_group_id = each.value.source_security_group_id
# }
