# ########################################  Security groups   #########################################################

vpc_id = "vpc-50a6a535"

  security_groups = {  
 }
# ###

listeners_map = {
  # "test-alb-external" = {
  #   listener_arn = "arn:aws:elasticloadbalancing:eu-west-1:455178800756:listener/app/test-alb-external/b780ad948abb6869/2925356490dc09a3"
  #   cert_arns    = [
  #     "arn:aws:acm:eu-west-1:455178800756:certificate/19bcc714-042e-43a3-9ab0-ecd51c84b478",
  #     "arn:aws:acm:eu-west-1:455178800756:certificate/074e50ac-fef2-4a71-8e14-6f58dfe60468",
  #     "arn:aws:acm:eu-west-1:455178800756:certificate/bd625e85-1ad9-4ef4-bff2-d6fae28ab314"
  #   ]
  # },
  
  "alb-ext-prod-office-only-listener" = {
    listener_arn = "arn:aws:elasticloadbalancing:eu-west-1:455178800756:listener/app/alb-ext-prod-office-only/49844b302b07e7cc/6f9d9ce8016fb166"
    cert_arns    = [
      "arn:aws:acm:eu-west-1:455178800756:certificate/19bcc714-042e-43a3-9ab0-ecd51c84b478",
      "arn:aws:acm:eu-west-1:455178800756:certificate/074e50ac-fef2-4a71-8e14-6f58dfe60468",
      "arn:aws:acm:eu-west-1:455178800756:certificate/bd625e85-1ad9-4ef4-bff2-d6fae28ab314"
    ]
  }
}