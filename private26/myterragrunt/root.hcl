locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = local.account_vars.locals.state_bucket
    key            = "tf/myterragrunt/${path_relative_to_include()}/terraform.tfstate"
    region         = local.account_vars.locals.aws_region
    dynamodb_table = local.account_vars.locals.lock_table
    encrypt        = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "${local.account_vars.locals.aws_region}"
}
EOF
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
EOF
}
