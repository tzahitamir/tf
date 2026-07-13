########################################  Security groups   #########################################################

vpc_id = "vpc-50a6a535"

security_groups = {
#   "web-sg-test1" = {
#     name        = "web-sg-test1"
#     description = "Security group for web servers"
#     ingress_rules = [
#       { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
#      # { from_port = 8000, to_port = 8000, protocol = "tcp", cidr_blocks = ["172.0.0.0/24"] },
#       { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
#     ]
#     egress_rules = [
#       { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
#     ]
#     tags = { Name = "web-sg-test1", Environment = "prod" }
#   }

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

  "allow-9999" = {
    name        = "allow-9999"
    description = "allow-9999"
    ingress_rules = [
      { from_port = 9999, to_port = 9999, protocol = "tcp", cidr_blocks = ["172.31.0.0/16"] }
      #{ from_port = 8000, to_port = 8000, protocol = "tcp", self = true }
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "allow-9999", Environment = "test" }
  } 
  
}
###