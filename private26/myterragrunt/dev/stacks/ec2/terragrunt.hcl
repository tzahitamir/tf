include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "sg" {
  config_path = "../sg"

  mock_outputs = {
    security_group_ids = {
      ollama_sg = "sg-00000000000000000"
    }
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

terraform {
  source = "../../../../modules/ec2"
}

inputs = {
  instances = {
    ollama = {
      ami                    = "ami-0b6d9d3d33ba97d99"
      instance_type          = "t3.medium"
      subnet_id              = "subnet-0a7fadf173e3a2fd9"
      vpc_security_group_ids = [dependency.sg.outputs.security_group_ids["ollama_sg"]]
      key_name               = "tzahi-kp-eu-east-1-9-7-26"
      # iam_instance_profile   = "REPLACE_ME" # e.g. "my-existing-instance-profile"
      root_volume_size = 20
      root_volume_type = "gp3"
      tags = {
        Name       = "ollama"
        owner      = "devops"
        created_at = "2026-07-14"
        project    = "proj-1"
      }
    }
  }
}
