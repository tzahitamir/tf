resource "aws_s3_bucket" "this" {
  for_each = var.buckets

  bucket = each.value.name

  tags = merge({
    logical_resource = each.value.logical_resource
    environment      = each.value.environment
    managed_by       = "terraform"
    created_at       = each.value.created_at
  }, var.extra_tags)
}

# Explicitly block all public access
resource "aws_s3_bucket_public_access_block" "this" {
  for_each = var.buckets
  bucket = aws_s3_bucket.this[each.key].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
