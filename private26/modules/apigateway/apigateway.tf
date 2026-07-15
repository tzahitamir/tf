resource "aws_apigatewayv2_api" "this" {
  for_each = var.apis

  name          = each.value.name
  protocol_type = "HTTP"
  tags          = each.value.tags
}

resource "aws_apigatewayv2_integration" "this" {
  for_each = var.apis

  api_id                 = aws_apigatewayv2_api.this[each.key].id
  integration_type       = "AWS_PROXY"
  integration_uri        = each.value.lambda_invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "this" {
  for_each = var.apis

  api_id    = aws_apigatewayv2_api.this[each.key].id
  route_key = each.value.route_key
  target    = "integrations/${aws_apigatewayv2_integration.this[each.key].id}"
}

resource "aws_apigatewayv2_stage" "this" {
  for_each = var.apis

  api_id      = aws_apigatewayv2_api.this[each.key].id
  name        = each.value.stage_name
  auto_deploy = true
  tags        = each.value.tags
}

resource "aws_lambda_permission" "apigw" {
  for_each = var.apis

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = each.value.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.this[each.key].execution_arn}/*/*"
}
