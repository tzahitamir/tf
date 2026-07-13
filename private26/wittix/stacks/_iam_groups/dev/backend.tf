#Wittix account
terraform {
backend "s3" {
    bucket         = "tzahi-temp" # REPLACE WITH YOUR BUCKET NAME
    key            = "tf/ecs/1/iam_groups_dev.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
}