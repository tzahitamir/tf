include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../modules/sg"
}

inputs = {
  vpc_id = "vpc-09d3963abbf6fc2ad"

  security_groups = {
    s3_file_test_sg = {
      name        = "s3-file-test-sg"
      description = "Allows inbound from my IP on 9876/3535 and from lambda-source-sg, outbound to all destinations"

      ingress_rules = [
        {
          from_port   = 9876
          to_port     = 9876
          protocol    = "tcp"
          cidr_blocks = ["147.235.195.114/32"]
        },
        {
          from_port   = 3535
          to_port     = 3535
          protocol    = "tcp"
          cidr_blocks = ["147.235.195.114/32"]
        },
        {
          from_port                 = 0
          to_port                   = 0
          protocol                  = "-1"
          source_security_group_ids = ["sg-049462b0ea580e51a"]
        }
      ]

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
        project = "prj-1"
      }
    }

    lambda_source_sg = {
      name        = "allow traffic from lambda-source-sg"
      description = "Only allows ingress from lambda-source-sg, outbound to all destinations"

      ingress_rules = [
        {
          from_port                 = 0
          to_port                   = 0
          protocol                  = "-1"
          source_security_group_ids = ["sg-049462b0ea580e51a"]
        }
      ]

      egress_rules = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]

      tags = {
        Name  = "allow traffic from lambda-source-sg"
        owner = "my-devops"
      }
    }
  }
}
