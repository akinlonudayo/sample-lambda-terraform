# IAM role for Lambda execution
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  name               = var.lambda_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Package the Lambda function code
data "archive_file" "functionCode" {
  type        = "zip"
  source_file = "${path.module}/src/index.js"
  output_path = "${path.module}/src/function.zip"
}

# Lambda function
resource "aws_lambda_function" "lambda_function_name" {
  filename         = data.archive_file.functionCode.output_path
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = var.lambda_function_handler
  source_code_hash = data.archive_file.functionCode.output_base64sha256

  runtime = var.lambda_function_runtime

  environment {
    variables = {
      ENVIRONMENT = "production"
      LOG_LEVEL   = "info"
    }
  }

  tags = {
    Environment = "production"
    Application = "example"
  }
}