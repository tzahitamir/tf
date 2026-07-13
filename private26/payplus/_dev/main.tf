module "aws_s3" {
  source = "../../modules/aws_s3"
  buckets    = var.s3_buckets
  extra_tags = var.extra_tags
}
