terraform {
  backend "s3" {
    bucket         = "pp-ops" 
    key            = "tf/tf/test/s3.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-state-locking"
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
  region = "eu-west-2"
}

# data "aws_vpc" "existing_vpc" {
#   filter {
#     name   = "tag:Name"
#     values = ["pay-plus-prod-vpc-vpc"]
#   }
# }


resource "aws_s3_bucket" "yosidevicetest" {
  bucket = "yosidevicetest"
  tags = {
    terraform = "true"
  }
}
resource "aws_s3_bucket" "payplus-vending-machine-logs" {
  bucket = "payplus-vending-machine-logs"
  tags = {
    terraform = "true"
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "yosidevicetest" {
  bucket = aws_s3_bucket.yosidevicetest.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "payplus-vending-machine-logs" {
  bucket = aws_s3_bucket.payplus-vending-machine-logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# Create policy for developer group access
resource "aws_iam_policy" "s3_full_access" {
  name        = "pp-developers-s3-full-access"
  description = "Full access to yosidevicetest S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:*"
        Resource = [
          aws_s3_bucket.yosidevicetest.arn,
          "${aws_s3_bucket.yosidevicetest.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "payplus-vending-machine-logs" {
  name        = "payplus-vending-machine-logs"
  description = "payplus-vending-machine-logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:*"
        Resource = [
          aws_s3_bucket.payplus-vending-machine-logs.arn,
          "${aws_s3_bucket.payplus-vending-machine-logs.arn}/*"
        ]
      }
    ]
  })
}

# Attach policy to developer group
resource "aws_iam_group_policy_attachment" "s3_full_access" {
  group      = "pp-developers"
  policy_arn = aws_iam_policy.s3_full_access.arn
}


resource "aws_iam_user_policy_attachment" "payplus-vending-machine-logs" {
  user       = "ProdENV"
  policy_arn = aws_iam_policy.payplus-vending-machine-logs.arn
}

resource "aws_s3_bucket_lifecycle_configuration" "vending_machine_logs_lifecycle" {
  bucket = "payplus-vending-machine-logs"

  rule {
    id     = "delete-after-14-days"
    status = "Enabled"

    filter {
      prefix = ""  # Apply to all objects
    }

    expiration {
      days = 14  # Delete objects 14 days after creation
    }
  }
}







