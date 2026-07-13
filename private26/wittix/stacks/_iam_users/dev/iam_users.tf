#IAM stack create a user ,with acees key and secret key in secrets manager

module "iam_users" {
  for_each   = local.iam_users
  source     = "../../../../modules/iam_users"

  user_name  = each.value.name
}
