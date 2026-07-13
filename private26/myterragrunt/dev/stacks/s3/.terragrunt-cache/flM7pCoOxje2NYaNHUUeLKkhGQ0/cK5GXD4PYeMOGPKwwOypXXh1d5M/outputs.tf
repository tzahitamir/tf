output "bucket_ids" {
  description = "IDs of the created S3 buckets."
  value       = { for k, b in aws_s3_bucket.this : k => b.id }
}

output "bucket_arns" {
  description = "ARNs of the created S3 buckets."
  value       = { for k, b in aws_s3_bucket.this : k => b.arn }
}
