variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "cluster_role_arn" {
  description = "The ARN of the IAM role for the EKS cluster."
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to use for the EKS cluster and node group."
  type        = list(string)
}

# variable "node_group_role_arn" {
#   description = "The ARN of the IAM role for the EKS node group."
#   type        = string
# }

# variable "node_group_name" {
#   description = "The name of the EKS node group."
#   type        = string
# }

variable "node_group_desired_size" {
  description = "The desired number of nodes in the node group."
  type        = number
  default     = 2
}

variable "node_group_max_size" {
  description = "The maximum number of nodes in the node group."
  type        = number
  default     = 3
}

variable "node_group_min_size" {
  description = "The minimum number of nodes in the node group."
  type        = number
  default     = 1
}

variable "node_group_instance_types" {
  description = "The instance types for the EKS node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}

variable "kubernetes_version" {
  type    = string
  default = "1.29"
}

variable "addons" {
  description = "Map of EKS addons to install"
  type = map(object({
    version                       = optional(string)
    resolve_conflicts_on_create   = optional(string, "OVERWRITE")
    resolve_conflicts_on_update   = optional(string, "OVERWRITE")
    service_account_role_arn      = optional(string)
    configuration_values          = optional(string)
  }))
  default = {}
}

variable "node_groups" {
  description = "List of node groups to create"
  type = list(object({
    name              = string
    instance_types    = list(string)
    desired_size      = number
    min_size          = number
    max_size          = number
    subnet_ids        = list(string)
    labels            = map(string)
    node_role_arn     = string
    launch_template_id      = optional(string)
    launch_template_version = optional(string, "$Latest")
  }))
  default = []
}

