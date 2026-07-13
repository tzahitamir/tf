
resource "aws_lb_listener" "nlb_listeners" {
  for_each = var.nlb_listeners

  load_balancer_arn = each.value.load_balancer_arn
  port     = each.value.port
  protocol = each.value.protocol 

  dynamic "default_action" {
    for_each = each.value.default_action
    content {
      type = default_action.value.type
      target_group_arn = default_action.value.target_group_arn
    }
    
}
}

