resource "aws_lambda_function" "lambda_zip_inline" {
  filename         = var.file_name
  source_code_hash = var.code_hash
  function_name    = var.function_name
  handler          = var.function_handler
  role             = var.function_role
  description      = var.function_description
  runtime          = var.function_runtime
  tags             = var.tags
}