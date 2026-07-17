include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../modules/iam_roles"
}

inputs = {
  iam_roles = {
    eks-cluster-role = {
      name = "eks-cluster-role"
      policy_json = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Principal = {
              Service = "eks.amazonaws.com"
            }
            Action = "sts:AssumeRole"
          }
        ]
      })
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
      ]
    }

    eks-node-role = {
      name = "eks-node-role"
      policy_json = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Principal = {
              Service = "ec2.amazonaws.com"
            }
            Action = "sts:AssumeRole"
          }
        ]
      })
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      ]
    }
  }
}
