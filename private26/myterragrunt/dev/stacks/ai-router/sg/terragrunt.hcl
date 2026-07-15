include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../modules/sg"
}

inputs = {
  vpc_id = "vpc-09d3963abbf6fc2ad"

  security_groups = {
    ollama_sg = {
      name        = "ollama_sg"
      description = "Allows HTTP from 172.16.0.0/16 and SSH from my IP, outbound to all destinations"

      ingress_rules = [
        {
          from_port   = 11434
          to_port     = 11434
          protocol    = "tcp"
          cidr_blocks = ["172.16.0.0/16"]
        },
        {
          from_port   = 11434
          to_port     = 11434
          protocol    = "tcp"
          cidr_blocks = ["147.235.195.114/32"]
        },
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["147.235.195.114/32"]
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
        Name       = "ollama_sg"
        owner      = "my-devops"
        created_at = "2026-07-14"
      }
    }

    ai_router_lambda_sg = {
      name        = "ai-router-lambda-sg"
      description = "Security group for the ai-router Lambda function VPC ENI"

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
        Name       = "ai-router-lambda-sg"
        owner      = "my-devops"
        created_at = "2026-07-15"
      }
    }
  }
}
#
