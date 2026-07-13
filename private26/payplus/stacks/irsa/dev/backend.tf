terraform {
backend "s3" {
    bucket         = "pp-ops"
    key            = "tf/state/platform/irsa-dev.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-state-locking"
    encrypt        = true
  }
}

