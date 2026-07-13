locals {


#vpc_id = data.aws_vpc.existing_vpc.id
#vpc_id = data.aws_vpc.existing_vpc.id
# public_subnets = data.aws_subnets.public.ids
# private_subnets = data.aws_subnets.private.ids

nlb_definitions = {
    "nlb-internal-test" = {
      name               = "nlb-internal-test"
      #internal           = false
      internal           = true
      load_balancer_type = "network"
      subnets            = data.aws_subnets.private.ids
      #Turn to true for prod#
      enable_deletion_protection = false
      tags = {
        Env = "test"
      }
    }#,
    # "internal-test-nlb" = {
    #   name               = "admin-nlb"
    #   internal           = true
    #   load_balancer_type = "network"
    #   subnets            = data.aws_subnets.private.ids
    #   #Turn to true for prod#
    #   enable_deletion_protection = false
    #   tags = {
    #     Env = "prod"
    #   }
    # }
 }

}