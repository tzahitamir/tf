include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "iam" {
  config_path = "../iam"

  mock_outputs = {
    iam_roles_arns = {
      "eks-cluster-role" = "arn:aws:iam::000000000000:role/mock"
      "eks-node-role"    = "arn:aws:iam::000000000000:role/mock"
    }
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

terraform {
  source = "../../../../../modules/eks"
}

inputs = {
  cluster_name       = "eks-dev"
  cluster_role_arn   = dependency.iam.outputs.iam_roles_arns["eks-cluster-role"]
  kubernetes_version = "1.36"

  subnet_ids = [
    "subnet-0e0b3200d979d2240",
    "subnet-0d0ec79bd05bf225a"
  ]

  node_groups = [
    {
      name           = "system"
      instance_types = ["t3.medium"]
      desired_size   = 1
      min_size       = 1
      max_size       = 2
      subnet_ids = [
        "subnet-0e0b3200d979d2240",
        "subnet-0d0ec79bd05bf225a"
      ]
      labels        = { role = "system" }
      node_role_arn = dependency.iam.outputs.iam_roles_arns["eks-node-role"]
    }
  ]

  addons = {
    vpc-cni                = { version = "v1.21.2-eksbuild.2" }
    coredns                = { version = "v1.14.2-eksbuild.4" }
    kube-proxy             = { version = "v1.36.0-eksbuild.7" }
    eks-pod-identity-agent = { version = "v1.3.10-eksbuild.3" }
    aws-ebs-csi-driver     = { version = "v1.62.0-eksbuild.1" }
    aws-efs-csi-driver     = { version = "v3.3.0-eksbuild.1" }
  }

  tags = {
    Name       = "eks-dev"
    owner      = "my-devops"
    project    = "proj-1"
    created_at = "2026-07-17"
  }
}
#
