# This module attaches IAM policies to users and roles based on the provided maps.


resource "aws_iam_role_policy_attachment" "attachments" {
  for_each = {
    for pair in flatten([
      for role_name, policies in var.role_policy_map : [
        for policy_name in policies : {
          key    = "${role_name}_${policy_name}"
          role   = role_name
          policy = policy_name
        }
      ]
    ]) : pair.key => pair
  }

   role       = each.value.role
   policy_arn = var.policy_arns[each.value.policy]
}








