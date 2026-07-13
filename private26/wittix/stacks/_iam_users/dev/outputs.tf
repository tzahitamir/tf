
# output "iam_users" {
#   #value = module.iam_users.user_name  # List of IAM user names
#   #sensitive = true
#   #value = user_name.name
#   value = module.iam_users.user_name[*]
#    #value = aws_iam_user.this[*].name
# }