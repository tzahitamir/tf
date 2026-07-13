data "terraform_remote_state" "iam_policies" {
  backend = "s3"
  config = {
    bucket = "pp-ops"
    key    = "tf/state/platform/iam_policies.tfstate"
    region = "eu-west-2"
  }
}

module "eso_irsa" {
  source = "../../../../modules/irsa"  # path to your IRSA module

  cluster_name               = "dev-eks"
  service_account_name       = "eso-dev"
  service_account_namespace  = "eso"
  oidc_provider_arn          = data.aws_iam_openid_connect_provider.eks.arn
  oidc_provider_url          = replace(data.aws_iam_openid_connect_provider.eks.url, "https://", "")
  policy_arns                = [
    module.iam_policies.eso_read_secret,   # pick only the policies you need
    module.iam_policies.s3_read_only
  ]
}
