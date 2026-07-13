resource "aws_eks_addon" "this" {
  for_each = var.addons

  cluster_name = aws_eks_cluster.main.name
  addon_name   = each.key

  addon_version = try(each.value.version, null)

  resolve_conflicts_on_create = try(
    each.value.resolve_conflicts_on_create,
    "OVERWRITE"
  )

  resolve_conflicts_on_update = try(
    each.value.resolve_conflicts_on_update,
    "OVERWRITE"
  )

  service_account_role_arn = try(
    each.value.service_account_role_arn,
    null
  )

  configuration_values = try(
    each.value.configuration_values,
    null
  )

  depends_on = [aws_eks_cluster.main]
}
