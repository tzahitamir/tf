locals {


#load_balancer_arn    = data.terraform_remote_state.nlb.outputs.nlb_arns_map["nlb-internal-test"]


listeners = {
    nlb-listener-1-test = {
      port     = 8000
      protocol = "TCP"
      load_balancer_arn    = data.terraform_remote_state.nlb.outputs.nlb_arns_map["nlb-internal-test"]
      default_action = [
        {
          type             = "forward"
          target_group_arn = data.terraform_remote_state.tg.outputs.target_group_arns_map["service1-tg-test"]
        }
      ]
    }
}

}