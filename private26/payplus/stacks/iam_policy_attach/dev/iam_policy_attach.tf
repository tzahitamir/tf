###############################################################################
# Remote-state data blocks
###############################################################################


data "terraform_remote_state" "iam_policies" {
  backend = "s3"
  config = {
    bucket = "pp-ops"
    key    = "tf/state/platform/iam_policies.tfstate"
    region = "eu-west-2"
  }
}


data "terraform_remote_state" "iam_roles" {
  backend = "s3"
  config = {
    bucket = "pp-ops"
    key    = "tf/state/platform/roles.tfstate"
    region = "eu-west-2"
  }
}

data "aws_iam_policy" "eks_cluster_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
data "aws_iam_policy" "AWSServiceRoleForAmazonEKSNodegroup" {
  #arn = "arn:aws:iam::aws:policy/AWSServiceRoleForAmazonEKSNodegroup"
  arn = "arn:aws:iam::aws:policy/aws-service-role/AWSServiceRoleForAmazonEKSNodegroup"
}

data "aws_iam_policy" "AmazonEKSVPCResourceController" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

data "aws_iam_policy" "AmazonEKSWorkerNodePolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
data "aws_iam_policy" "AmazonEKS_CNI_Policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
data "aws_iam_policy" "AmazonEC2ContainerRegistryReadOnly" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

data "aws_iam_policy" "AmazonEFSCSIDriverPolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
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

# This module attaches both custom and AWS-managed policies
module "iam_policy_attach" {
  source = "../../../../modules/iam_policy_attach"

  # For custom policies
  policy_arns     = local.policy_arns
  role_policy_map = local.role_policy_map

  # For AWS-managed policies
  role_policy_map_aws = local.role_policy_map_aws
}
