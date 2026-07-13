


data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["pay-plus-prod-vpc-vpc"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "availability-zone"
    values = ["eu-west-2b", "eu-west-2c"]
  }
  tags = {
    Tier = "public"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "availability-zone"
    values = ["eu-west-2b", "eu-west-2c"]
  }
  tags = {
    Tier = "private"
  }
}

resource "aws_launch_template" "eks_v2" {
  name_prefix = "payplus-nodes-"
  description = "EKS Launch Template with IMDSv2 Hop Limit 2"

  # This is the specific fix you need
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required" # Enforce IMDSv2
    http_put_response_hop_limit = 2          # Allow pods to see metadata
  }

  # If you need custom security groups or storage, add them here:
  # vpc_security_group_ids = [var.node_sg_id]
  
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 50
      volume_type = "gp3"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Project = "PayPlus"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

module "eks_cluster" {
  source = "../../../../modules/eks"

  # ---- Cluster ----
  cluster_name          = "payplus-dev-eks"
  kubernetes_version = "1.31"
  cluster_role_arn      = "arn:aws:iam::713117837264:role/eksClusterRole-dev"      

  # ---- Networking ----
  subnet_ids = concat(data.aws_subnets.private.ids, data.aws_subnets.public.ids)

node_groups = [
   # {
    #   name           = "private-ng-dev"
    #   instance_types = ["t3.medium"]
    #   desired_size   = 9
    #   min_size       = 1
    #   max_size       = 9
    #   subnet_ids     = data.aws_subnets.private.ids
    #   labels         = { "role" = "private" }
    #   node_role_arn  = "arn:aws:iam::713117837264:role/eks_node_role_dev"
    #   ami_type = "AL2023_x86_64_STANDARD"
    #   version  = "1.31"
    # },
    {
      name           = "private-ng-dev-new"
      instance_types = ["t3.medium"]
      desired_size   = 9
      min_size       = 1
      max_size       = 9
      subnet_ids     = data.aws_subnets.private.ids
      labels         = { "role" = "private" , "eks_v2" = "yes"}
      node_role_arn  = "arn:aws:iam::713117837264:role/eks_node_role_dev"
      launch_template_id = aws_launch_template.eks_v2.id
      launch_template_version = "$Latest"
    },
    {
      name           = "pub-sub-ng-dev-new"
      instance_types = ["t3.medium"]
      desired_size   = 2
      min_size       = 2
      max_size       = 2
      subnet_ids     = data.aws_subnets.public.ids
      labels         = { "pub-sub" = "yes" , "eks_v2" = "yes"}
      node_role_arn  = "arn:aws:iam::713117837264:role/eks_node_role_dev"
      launch_template_id = aws_launch_template.eks_v2.id
      launch_template_version = "$Latest"
    }
  ]

# ---- Addons (optional) ----
addons = {
    coredns = {
      version = "v1.11.4-eksbuild.28"
    }

    kube-proxy = {
      version = "v1.31.14-eksbuild.5"
    }

    vpc-cni = {
      version = "v1.21.1-eksbuild.3"
    }

    aws-ebs-csi-driver = {
      version = "v1.35.0-eksbuild.1"
      #service_account_role_arn = aws_iam_role.AmazonEKS_EBS_CSI_DriverRole.arn
      service_account_role_arn = "arn:aws:iam::713117837264:role/AmazonEKS_EBS_CSI_DriverRole_payplus-dev-eks"
    }
    aws-efs-csi-driver = {
      version = "v2.3.0-eksbuild.2"
      service_account_role_arn = "arn:aws:iam::713117837264:role/EKS_EFS_CSI_Driver_Role_dev"
    }

  # Example of overriding default settings:
  #   kube-proxy = {
  #   version                     = "v1.29.0-eksbuild.1"
  #   resolve_conflicts_on_update = "NONE"
  # }

  }

# ---- Tags ----
 tags = {
   Environment = "dev"
   Project     = "PayPlus"
  }
}
