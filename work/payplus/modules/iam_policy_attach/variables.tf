
variable "role_policy_map" {
  description = "Mapping of role names to list of policy names"
  type        = map(list(string))
}

variable "policy_arns" {
  description = "Map of policy name to ARN"
  type        = map(string)
}
