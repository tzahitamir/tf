module "iam_roles" {
  source = "../../../../modules/iam_roles"
  iam_roles = var.iam_roles
}


output "iam_roles_arns" {
  value = module.iam_roles.iam_roles_arns
}
