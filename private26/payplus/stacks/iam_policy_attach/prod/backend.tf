terraform {
  backend "s3" {
    bucket = "pp-ops"
    key    = "tf/state/platform/iam_policy_attach_prod.tfstate"
    #key            = "tf/state/platform/iam_policies.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-state-locking"
    encrypt        = true
  }
}