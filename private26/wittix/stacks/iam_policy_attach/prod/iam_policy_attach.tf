###############################################################################
# Remote-state data blocks
###############################################################################


data "terraform_remote_state" "iam_policies" {
  backend = "s3"
  config  = {
    bucket = "tzahi-temp"
    key    = "tf/ecs/1/iam_policies_prod.tfstate"
    region = "eu-west-1"
  }
}

data "terraform_remote_state" "iam_roles" {
  backend = "s3"
  config  = {
    bucket = "tzahi-temp"
    key    = "tf/ecs/1/iam_roles-prod.tfstate"
    region = "eu-west-1"
  }
}

###############################################################################
# Local copies of the two maps you already output:
#
# iam_policy_arns   = { policy_name => arn }
# iam_roles_arns    = { role_name   => arn }
###############################################################################
locals {
  policy_arns = data.terraform_remote_state.iam_policies.outputs.iam_policy_arns
}

#This is to attach custom policies to roles
module "iam_policy_attach" {
  source = "../../../../modules/iam_policy_attach"
  policy_arns = local.policy_arns
  role_policy_map = local.role_policy_map
}

#This is to attach AWS policies to roles

# module "iam_policy_attach_aws_managed" {
#   source = "../../../../modules/iam_policy_attach"
#   role_policy_map_aws = local.role_policy_map_aws
# }
