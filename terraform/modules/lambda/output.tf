
output "lambda_zip_inline_arn" {
  value = aws_lambda_function.lambda_zip_inline.arn
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function"
}

output "lambda_zip_inline_qualified_arn" {
  value = aws_lambda_function.lambda_zip_inline.qualified_arn
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true)"
}

output "lambda_zip_inline_invoke_arn" {
  value = aws_lambda_function.lambda_zip_inline.invoke_arn
  description = "The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri"
}

