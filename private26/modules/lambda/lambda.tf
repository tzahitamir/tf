data "archive_file" "placeholder" {
  type        = "zip"
  source_dir  = "${path.module}/placeholder"
  output_path = "${path.module}/placeholder.zip"
}

resource "aws_lambda_function" "this" {
  for_each = var.functions

  function_name = each.value.function_name
  role          = each.value.role_arn
  handler       = each.value.handler
  runtime       = each.value.runtime
  timeout       = each.value.timeout
  memory_size   = each.value.memory_size

  filename         = data.archive_file.placeholder.output_path
  source_code_hash = data.archive_file.placeholder.output_base64sha256

  dynamic "environment" {
    for_each = length(each.value.environment_variables) > 0 ? [each.value.environment_variables] : []
    content {
      variables = environment.value
    }
  }

  tags = each.value.tags

  lifecycle {
    ignore_changes = [filename, source_code_hash]
  }
}
