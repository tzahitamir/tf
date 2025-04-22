# Variables for IAM roles module


variable "iam_roles" {
  description = "Map of IAM roles"
  type        = map(object({
    name   = string
    policy_json   = any
  }))
}


