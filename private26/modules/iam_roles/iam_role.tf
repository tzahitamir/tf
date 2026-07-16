
resource "aws_iam_role" "myroles" {
  for_each    = var.iam_roles

  name        = each.key
  assume_role_policy = each.value.policy_json
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = {
    for pair in flatten([
      for role_key, role in var.iam_roles : [
        for policy_arn in role.managed_policy_arns : {
          key        = "${role_key}_${basename(policy_arn)}"
          role       = role_key
          policy_arn = policy_arn
        }
      ]
    ]) : pair.key => pair
  }

  role       = aws_iam_role.myroles[each.value.role].name
  policy_arn = each.value.policy_arn
}

resource "aws_iam_role_policy" "inline" {
  for_each = {
    for pair in flatten([
      for role_key, role in var.iam_roles : [
        for policy_name, policy_json in role.inline_policies : {
          key         = "${role_key}_${policy_name}"
          role        = role_key
          policy_name = policy_name
          policy_json = policy_json
        }
      ]
    ]) : pair.key => pair
  }

  name   = each.value.policy_name
  role   = aws_iam_role.myroles[each.value.role].name
  policy = each.value.policy_json
}


