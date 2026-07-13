variable "iam_policies" {
  description = "Map of IAM policies with their names and documents"
  type        = map(object({
    description   = string
    policy_json   = any
  }))
}






