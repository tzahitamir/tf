locals {
  common_tags = merge(
    {
      ManagedBy = "Terraform"
      Platform  = "eks"
    },
    var.tags
  )
}
