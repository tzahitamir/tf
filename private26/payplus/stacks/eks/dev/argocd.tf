
# # ==========================================
# # Argo CD bootstrap (do not add k8s apps below)
# # ==========================================

##
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "6.7.12" 
  namespace        = "argocd"
  create_namespace = false 

  values = [<<EOF
server:
  extraArgs:
    - --insecure
  route:
    enabled: false
  service:
    type: ClusterIP
EOF
  ]

  lifecycle {
    prevent_destroy = true
  }

  depends_on = [
    module.eks_cluster
  ]
}
##
