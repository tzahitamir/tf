terraform {
  backend "s3" {
    bucket         = "tzahi-temp" # REPLACE WITH YOUR BUCKET NAME
    key            = "tf/s3/s3.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    
  }
}

provider "aws" {
  region = "eu-west-1"
}

# data "aws_vpc" "existing_vpc" {
#   filter {
#     name   = "tag:Name"
#     values = ["pay-plus-prod-vpc-vpc"]
#   }
# }


resource "aws_s3_bucket" "wittix-opensearch-backup-bucket" {
  bucket = "wittix-opensearch-backup-bucket"
  tags = {
    terraform = "true"
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "wittix-opensearch-backup-bucket" {
  bucket = aws_s3_bucket.wittix-opensearch-backup-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_role" "wittix_opensearch_backup_role" {
  name = "wittix_opensearch_backup_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "es.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    terraform = "true"
  }
}


resource "aws_iam_policy" "wittix-opensearch-backup-bucket_s3_access" {
  name        = "wittix-opensearch-backup-bucket_s3_access"
  description = "wittix-opensearch-backup-bucket S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
        "Resource": [
        "arn:aws:s3:::wittix-opensearch-backup-bucket",
        "arn:aws:s3:::wittix-opensearch-backup-bucket/*"
      ]
      }
    ]
  })
}

# Attach policy to developer group
resource "aws_iam_role_policy_attachment" "wittix-s3-attach" {
  role       = aws_iam_role.wittix_opensearch_backup_role.name
  policy_arn = aws_iam_policy.wittix-opensearch-backup-bucket_s3_access.arn
}



