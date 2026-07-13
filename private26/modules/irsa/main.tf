# Create the IAM role for IRSA
resource "aws_iam_role" "irsa" {
  name = "${var.cluster_name}-${var.service_account_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${var.oidc_provider_url}:sub" = "system:serviceaccount:${var.service_account_namespace}:${var.service_account_name}"
          }
        }
      }
    ]
  })
}

# Attach only the selected policies
resource "aws_iam_role_policy_attachment" "attach" {
  for_each = toset(var.policy_arns)

  role       = aws_iam_role.irsa.name
  policy_arn = each.value
}

# Optional output
output "irsa_role_arn" {
  value = aws_iam_role.irsa.arn
}

output "irsa_role_name" {
  value = aws_iam_role.irsa.name
}
