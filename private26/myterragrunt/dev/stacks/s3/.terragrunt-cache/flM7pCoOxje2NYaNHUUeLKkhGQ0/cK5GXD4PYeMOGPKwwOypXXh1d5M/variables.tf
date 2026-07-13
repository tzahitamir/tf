variable "buckets" {
  description = "Map of S3 buckets to create. Keys are unique bucket identifiers."
  type = map(object({
    name             = string
    logical_resource = string
    environment      = string
    created_at       = string
  }))
}

variable "extra_tags" {
  description = "Additional tags to apply to all buckets."
  type        = map(string)
  default     = {}
}
