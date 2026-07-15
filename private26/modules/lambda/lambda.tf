data "archive_file" "placeholder" {
  type        = "zip"
  source_dir  = "${path.module}/placeholder"
  output_path = "${path.module}/placeholder.zip"
}

locals {
  ssm_lookups = merge([
    for fn_key, fn in var.functions : {
      for env_key, param_name in fn.ssm_environment_variables :
      "${fn_key}.${env_key}" => param_name
    }
  ]...)
}

data "aws_ssm_parameter" "env" {
  for_each = local.ssm_lookups

  name            = each.value
  with_decryption = true
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
    for_each = length(each.value.environment_variables) > 0 || length(each.value.ssm_environment_variables) > 0 ? [1] : []
    content {
      variables = merge(
        each.value.environment_variables,
        {
          for env_key, param_name in each.value.ssm_environment_variables :
          env_key => data.aws_ssm_parameter.env["${each.key}.${env_key}"].value
        }
      )
    }
  }

  dynamic "vpc_config" {
    for_each = length(each.value.vpc_subnet_ids) > 0 ? [1] : []
    content {
      subnet_ids         = each.value.vpc_subnet_ids
      security_group_ids = each.value.vpc_security_group_ids
    }
  }

  tags = each.value.tags

  lifecycle {
    ignore_changes = [filename, source_code_hash]
  }
}
