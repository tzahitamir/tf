locals {
  # This map links a role name to a list of AWS-managed policy ARNs.
  # The module's "managed" resource block is designed to read this variable.
  role_policy_map_aws = {
    "eksClusterRole-dev" = [
      # This references the data block in iam_policy_attach.tf to get the policy ARN.
      data.aws_iam_policy.eks_cluster_policy.arn, data.aws_iam_policy.AmazonEKSVPCResourceController.arn
    ],
    "eks_node_role_dev" = [
      data.aws_iam_policy.AmazonEKSWorkerNodePolicy.arn,
      data.aws_iam_policy.AmazonEKS_CNI_Policy.arn,
      data.aws_iam_policy.AmazonEC2ContainerRegistryReadOnly.arn
    ],
    "EKS_EFS_CSI_Driver_Role_dev" = [
      data.aws_iam_policy.AmazonEFSCSIDriverPolicy.arn
    ]
  }

  # This map is for your custom-managed policies.
  # If you don't have any for this environment, an empty map is fine.
  role_policy_map = {
    "s3-tzahi-reader-role"     = ["s3-access-tzahi-bucket", "s3-pp-ops-read"],
    "pp-read-secret-beta-role" = ["pp-read-secret-beta"],
    "eks_node_role_dev"        = ["pp-read-secret-beta"]
    
  }
  #role_policy_map = {}
}



