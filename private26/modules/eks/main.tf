resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version


  
  vpc_config {
    subnet_ids = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  tags = merge(
    local.common_tags,
    {
      Name = var.cluster_name
    }
  )
}

# Create multiple node groups dynamically
resource "aws_eks_node_group" "ng" {
  for_each = { for ng in var.node_groups : ng.name => ng }

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = each.value.name
  node_role_arn   = each.value.node_role_arn
  subnet_ids      = each.value.subnet_ids
  instance_types  = each.value.instance_types

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

# --- DYNAMIC LAUNCH TEMPLATE BLOCK ---
  dynamic "launch_template" {
    # Only create this block if launch_template_id is not null
    for_each = each.value.launch_template_id != null ? [1] : []
    
    content {
      id      = each.value.launch_template_id
      version = each.value.launch_template_version
    }
  }


  labels = each.value.labels

  tags = merge(
    local.common_tags,
    { Name = each.value.name }
  )
}

#OIDC identity provider
data "aws_eks_cluster" "this" {
  name = aws_eks_cluster.main.name
}

data "aws_eks_cluster_auth" "this" {
  name = aws_eks_cluster.main.name
}

data "tls_certificate" "oidc" {
  url = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "this" {
  url = data.aws_eks_cluster.this.identity[0].oidc[0].issuer

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.oidc.certificates[0].sha1_fingerprint
  ]

  tags = local.common_tags
}
