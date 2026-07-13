########################################  Security groups   #########################################################

vpc_id = "vpc-50a6a535"

security_groups = {
  "allow-443-prod" = {
    name        = "allow-443-prod"
    description = "allow-443-prod"
    ingress_rules = [
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "allow-443-prod", Environment = "prod" , terraform = "true" }
  },
  "allow-3000-prod" = {
    name        = "allow-3000-prod"
    description = "allow-3000-prod"
    ingress_rules = [
      { from_port = 3000, to_port = 3000, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "allow-3000-prod", Environment = "prod" , terraform = "true" }
  }
  "allow-443-cf" = {
    name        = "allow-443-cf"
    description = "allow-443-cf"
    ingress_rules = [
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["173.245.48.0/20"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["103.21.244.0/22"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["103.22.200.0/22"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["103.31.4.0/22"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["141.101.64.0/18"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["108.162.192.0/18"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["190.93.240.0/20"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["188.114.96.0/20"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["197.234.240.0/22"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["198.41.128.0/17"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["162.158.0.0/15"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["104.16.0.0/13"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["104.24.0.0/14"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["172.64.0.0/13"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["131.0.72.0/22"] }
      
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "allow-443-cf", Environment = "prod" , terraform = "true" }
  },
  # "allow-grpc-50051" = {
  #   name        = "allow-grpc-50051"
  #   description = "allow-grpc-50051"
  #   ingress_rules = [
  #     { from_port = 50051, to_port = 50051, protocol = "tcp", cidr_blocks = ["172.31.0.0/16"] }
  #   ]
  #   egress_rules = [
  #     { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
  #   ]
  #   tags = { Name = "allow-grpc-50051", Environment = "prod" , terraform = "true" }
  # },
  "allow-grpc-50051-from-office" = {
    name        = "allow-grpc-50051-from-office"
    description = "allow-grpc-50051-from-office"
    ingress_rules = [
      { from_port = 50051, to_port = 50051, protocol = "tcp", cidr_blocks = ["81.2.146.62/32"] },
      { from_port = 50051, to_port = 50051, protocol = "tcp", cidr_blocks = ["77.137.30.93/32"] }
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "allow-grpc-50051-from-office", Environment = "prod" , terraform = "true" }
  },
  "allow-grpc-50051-from-aws" = {
    name        = "allow-grpc-50051-from-aws"
    description = "allow-grpc-50051-from-aws"
    ingress_rules = [
      { from_port = 50051, to_port = 50051, protocol = "tcp", cidr_blocks = ["52.210.162.10/32"] },
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "allow-grpc-50051-from-aws", Environment = "prod" , terraform = "true" }
  },
  "alb-sg-test-tf" = {
    name        = "alb-sg-test-tf"
    description = "alb-sg-test-tf"
    ingress_rules = [
      { from_port = 50051, to_port = 50051, protocol = "tcp", cidr_blocks = ["52.210.162.10/32"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["52.210.162.10/32"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["81.2.146.62/32"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["77.137.30.93/32"] },
      { from_port = 50051, to_port = 50051, protocol = "tcp", cidr_blocks = ["172.31.0.0/16"] }
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "alb-sg-test-tf", Environment = "test" , terraform = "true" }
  },
   "alb-sg-prod-tf" = {
    name        = "alb-sg-prod-tf"
    description = "alb-sg-prod-tf"
    ingress_rules = [
      { from_port = 50051, to_port = 50051, protocol = "tcp", cidr_blocks = ["52.210.162.10/32"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["52.210.162.10/32"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["81.2.146.62/32"] },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["77.137.30.93/32"] },
      { from_port = 50051, to_port = 50051, protocol = "tcp", cidr_blocks = ["172.31.0.0/16"] }
    ]
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "alb-sg-prod-tf", Environment = "prod" , terraform = "true" }
  },
  "allow-3000-internal-only" = {
    name        = "allow-3000-internal-only"
    description = "allow-3000-internal-only"
    ingress_rules = [
      { from_port = 3000, to_port = 3000, protocol = "tcp", cidr_blocks = ["172.31.0.0/16"] },
    ]
    
    egress_rules = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = { Name = "allow-3000-internal-only", Environment = "prod" , terraform = "true" }
  }
  # "allow-3333-internal-tf" = {
  #   name        = "allow-3333-internal-tf"
  #   description = "allow-3333-internal-tf"
  #   ingress_rules = [
  #     { from_port = 3333, to_port = 3333, protocol = "tcp", cidr_blocks = ["172.31.0.0/16"] },
  #   ]
    
  #   egress_rules = [
  #     { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
  #   ]
  #   tags = { Name = "allow-3333-internal-tf", Environment = "prod" , terraform = "true" }
  # }
  

}
