include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../modules/aws_s3"
}

inputs = {
  buckets = {
    example = {
      name             = "my-dev-example"
      logical_resource = "s3_dev_my_example"
      environment      = "dev"
      created_at       = "2026-07-13"
    }
  }

  extra_tags = {
    owner = "my-devops"
  }
}
