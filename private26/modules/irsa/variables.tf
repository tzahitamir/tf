variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "service_account_name" {
  description = "Name of the Kubernetes Service Account"
  type        = string
}

variable "service_account_namespace" {
  description = "Namespace of the Kubernetes Service Account"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the OIDC provider for the EKS cluster"
  type        = string
}

variable "oidc_provider_url" {
  description = "URL of the OIDC provider (without https://) for the EKS cluster"
  type        = string
}

variable "policy_arns" {
  description = "List of policy ARNs to attach to this role"
  type        = list(string)
  default     = []
}
