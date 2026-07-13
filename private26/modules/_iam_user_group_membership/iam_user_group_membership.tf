resource "aws_iam_user_group_membership" "memberships" {
  for_each = var.user_group_map

  user = each.key
  groups = each.value
}