
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
    #no need to loop through condition as it is a single objectß
    host_header {
          values = each.value.condition.host_header.values
        }
      }
}



 







