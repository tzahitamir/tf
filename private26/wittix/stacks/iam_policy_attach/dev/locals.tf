#roles can be find by running tf output at /home/tf/repo/ops/tf/wittix/stacks/iam_roles/dev
#policies can be find by running tf output at /home/tf/repo/ops/tf/wittix/stacks/iam_policies/dev

locals {
  role_policy_map = {
    "ro-role-test1" = ["wecs-log-policy-test"]
  }
}

