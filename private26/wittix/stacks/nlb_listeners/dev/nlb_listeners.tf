data "terraform_remote_state" "nlb" {
  backend = "s3"
  config  = {
    bucket = "tzahi-temp"
    key    = "tf/ecs/1/nlbdev.tfstate"
    region = "eu-west-1"
  }
}

data "terraform_remote_state" "tg" {
  backend = "s3"
  config  = {
    bucket = "tzahi-temp"
    key    = "tf/ecs/1/tgdev.tfstate"
    region = "eu-west-1"
  }
}


module "listeners" {
  source = "../../../../modules/listeners"
  nlb_listeners = local.listeners
  # depends_on = [
  #   module.nlb
  # ]
}