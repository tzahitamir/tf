resource "aws_iam_group" "this" {
  for_each = var.group_names
  name     = each.key
  path = each.value.path
}



