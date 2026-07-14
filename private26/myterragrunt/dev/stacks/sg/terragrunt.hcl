include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../modules/sg"
}

inputs = {
  name        = "s3-file-test-sg"
  description = "Outbound-only security group, all destinations"
  vpc_id      = "vpc-09d3963abbf6fc2ad"

  ingress_rules = []

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Name  = "s3-file-test-sg"
    owner = "my-devops"
  }
}
