terraform {
backend "s3" {
    bucket         = "pp-ops"
    key            = "tf/state/platform/roles.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-state-locking"
    encrypt        = true
  }
}

