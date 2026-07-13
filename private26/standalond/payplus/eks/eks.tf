terraform {
  backend "s3" {
    bucket         = "pp-ops"
    key            = "tf/tf/test/eks.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-state-locking"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Get the existing VPC
data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = ["main"]
  }
}

# Get all subnets in the VPC
data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }
}

# Get subnet IDs as a list
locals {
  subnet_ids = data.aws_subnets.all.ids
}

# EKS Cluster
resource "aws_eks_cluster" "eks" {
  name     = "eks-tf"
  role_arn = "arn:aws:iam::713117837264:role/eksClusterRole"
  version  = "1.27"

  vpc_config {
    subnet_ids         = local.subnet_ids
    endpoint_public_access = true
    endpoint_private_access = false
    security_group_ids = ["sg-0d8d563b4f368a4de"]
  }

  kubernetes_network_config {
    service_ipv4_cidr = null # Use default
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # Authentication mode: EKS API and ConfigMap
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
}

# EKS Add-ons
resource "aws_eks_addon" "coredns" {
  cluster_name   = aws_eks_cluster.eks.name
  addon_name     = "coredns"
  addon_version  = "v1.10.1-eksbuild.2"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name   = aws_eks_cluster.eks.name
  addon_name     = "vpc-cni"
  addon_version  = "v1.13.3-eksbuild.1"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name   = aws_eks_cluster.eks.name
  addon_name     = "kube-proxy"
  addon_version  = "v1.27.4-eksbuild.2"
}

resource "aws_eks_addon" "ebs_csi" {
  cluster_name   = aws_eks_cluster.eks.name
  addon_name     = "aws-ebs-csi-driver"
  addon_version  = "v1.20.0-eksbuild.1"
}

# Node Group
resource "aws_eks_node_group" "ng_tf" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "ng-tf"
  node_role_arn   = "arn:aws:iam::713117837264:role/AmazonEKSNodeRole"
  subnet_ids      = local.subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  remote_access {
    ec2_ssh_key = null # Set your SSH key name if needed
  }

  ami_type = "AL2_x86_64"

  update_config {
    max_unavailable = 1
  }
}


# Output cluster info
output "cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "node_group_arn" {
  value = aws_eks_node_group.ng_tf.arn
}
