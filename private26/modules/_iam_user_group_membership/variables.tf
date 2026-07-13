variable "user_group_map" {
  description = "Map of users to list of groups"
  type        = map(list(string))
}