provider "aws" {
  region = "eu-west-2"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_ca_certificate)
  token                  = data.aws_eks_cluster_auth.this.token
}

provider "helm" {
  kubernetes = {
    host                   = module.eks_cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.cluster_ca_certificate)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}


data "aws_eks_cluster_auth" "this" {
  name = module.eks_cluster.cluster_name
}
