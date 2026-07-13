
variable "role_policy_map" {
  description = "Mapping of role names to list of policy names"
  type        = map(list(string))
  default     = {}  # Optional by default
}


variable "policy_arns" {
  description = "Map of policy name to ARN"
  type        = map(string)
  default     = {}  # Optional by default
}

variable "role_policy_map_aws" {
  description = "Mapping of role names to list of policy names"
  type        = map(list(string))
  default     = {}  # Optional by default
}

# variable "aws_managed_policy_arns" {
#   type        = list(string)
#   description = "AWS managed policy ARNs (e.g., AmazonS3ReadOnlyAccess)"
#   default     = []  # Optional by default
# }
