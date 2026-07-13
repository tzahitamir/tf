
module "iam_groups" {
  source     = "../../../../modules/iam_groups" # adjust path to your module
  group_names = local.group_names
}
