
resource "aws_iam_role" "myroles" {
  for_each    = var.iam_roles

  name        = each.key
  assume_role_policy = jsonencode(each.value.policy_json)
}


