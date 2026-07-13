terraform {
  backend "s3" {
    bucket         = "tzahitamirtf"
    key            = "tf/my/network/s3.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
}
