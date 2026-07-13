terraform {
backend "s3" {
    bucket         = "pp-ops"
    key            = "tf/state/platform/eksdev.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-state-locking"
    encrypt        = true
  }
}