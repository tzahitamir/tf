module "iam_roles" {
  source    = "../../../../modules/iam_roles"
  iam_roles = local.iam_roles
 # cluster_name = local.cluster_name
}
