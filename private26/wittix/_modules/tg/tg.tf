resource "aws_lb_target_group" "tgs" {
  for_each = var.tgs

  name        = each.value.name
  port        = each.value.port
  protocol    = each.value.protocol
  target_type = each.value.target_type
  vpc_id      = each.value.vpc_id
  #create the resource only of it was defined 
  dynamic "stickiness" {
    for_each = each.value.stickiness != null ? [each.value.stickiness] : []
    content {
      type            = stickiness.value.type
      enabled         = stickiness.value.enabled
      cookie_duration = stickiness.value.cookie_duration
    }
  }

}
