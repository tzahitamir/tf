terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# variable "buckets" {
#   description = "Map of S3 buckets to create."
#   type        = any
# }

# variable "extra_tags" {
#   description = "Additional tags to apply to all buckets."
#   type        = map(string)
#   default     = {}
# }

# module "aws_s3" {
#   source = "../../../../modules/aws_s3"

#   buckets    = var.buckets
#   extra_tags = var.extra_tags
# }
