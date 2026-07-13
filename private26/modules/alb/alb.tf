
resource "aws_lb" "albs" {
  for_each = var.albs

  name                        = each.value.name
  internal                    = each.value.internal
  load_balancer_type          = each.value.load_balancer_type
  subnets                     = each.value.subnets
  security_groups             = each.value.security_groups
  enable_deletion_protection  = each.value.enable_deletion_protection
  tags                        = each.value.tags
}

resource "aws_lb_listener" "alb_listener" {
  for_each = var.alb_listeners

  load_balancer_arn = each.value.load_balancer_arn
  port              = each.value.port
  protocol          = each.value.protocol
  ssl_policy        = each.value.ssl_policy
  certificate_arn   = each.value.certificate_arn

  dynamic "default_action" {
    for_each = each.value.default_action
    content {
    type             = default_action.value.type
    target_group_arn = default_action.value.target_group_arn
    }
  }
}

resource "aws_lb_listener_rule" "alb_listener_rules" {
  for_each = var.alb_listener_rules

  listener_arn = each.value.listener_arn
  priority     = each.value.priority

  dynamic "action" {
    for_each = each.value.action
    content {
      type             = action.value.type
      target_group_arn = action.value.target_group_arn
 
    }  
  }  
  condition {
    #no need to loop through condition as it is a single object
    host_header {
          values = each.value.condition.host_header.values
        }
      }
}
 
resource "aws_lb_listener_certificate" "sni" {
  for_each = {
    for pair in flatten([
      for name, data in var.listeners_map : [
        for cert in data.cert_arns : {
          key      = "${name}-${cert}"
          l_arn    = data.listener_arn
          cert_arn = cert
        }
      ]
    ]) : pair.key => pair
  }

  listener_arn    = each.value.l_arn
  certificate_arn = each.value.cert_arn
}







