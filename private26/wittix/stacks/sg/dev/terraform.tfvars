########################################  Security groups   #########################################################

vpc_id = "vpc-50a6a535"

security_groups = {
  "web-sg-allow-443-test" = {
    name        = "web-sg-allow-443-test"
    description = "web-sg-allow-443-test"
    ingress_rules = [
     # { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
     # { from_port = 8000, to_port = 8000, protocol = "tcp", cidr_blocks = ["172.0.0.0/24"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "web-sg-allow-443-test", Environment = "test" }
  }

#   "ssh-sg-test" = {
#     name        = "ssh-sg-test"
#     description = "Security group for ssh"
#     ingress_rules = [
#       { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
      
#     ]
#     egress_rules = [
#       { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
#     ]
#     tags = { Name = "ssh-sg-test", Environment = "prod" }
#   } 

  "allow-8000-tf-test" = {
    name        = "allow-8000-tf-test"
    description = "allow-8000-tf-test"
    ingress_rules = [
      { from_port = 8000, to_port = 8000, protocol = "tcp", cidr_blocks = ["172.31.0.0/16"] }
      #{ from_port = 8000, to_port = 8000, protocol = "tcp", self = true }
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "allow-8000-tf-test", Environment = "test" }
  } 
  
}
###