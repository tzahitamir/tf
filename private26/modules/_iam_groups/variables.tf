variable "group_names" {
  description = "Map of group names to create"
  type = map(object({
    path = optional(string, "/")
  }))
}


