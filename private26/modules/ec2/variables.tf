variable "instances" {
  description = "Map of EC2 instances to create. Keys are unique instance identifiers."
  type = map(object({
    ami                         = string
    instance_type               = string
    subnet_id                   = string
    vpc_security_group_ids      = optional(list(string), [])
    key_name                    = optional(string)
    iam_instance_profile        = optional(string)
    associate_public_ip_address = optional(bool, false)
    root_volume_size            = optional(number, 8)
    root_volume_type            = optional(string, "gp3")
    tags                        = map(string)
  }))
}
