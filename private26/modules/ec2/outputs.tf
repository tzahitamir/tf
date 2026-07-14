output "instance_ids" {
  description = "IDs of the created EC2 instances."
  value       = { for k, i in aws_instance.this : k => i.id }
}

output "private_ips" {
  description = "Private IP addresses of the created EC2 instances."
  value       = { for k, i in aws_instance.this : k => i.private_ip }
}

output "public_ips" {
  description = "Public IP addresses of the created EC2 instances, if assigned."
  value       = { for k, i in aws_instance.this : k => i.public_ip }
}
