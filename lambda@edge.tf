provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "headers.js"
  output_path = "headers.zip"
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_service_role" {
  name               = "lambda_service_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
  provider         = aws.us_east_1
}

resource "aws_iam_role_policy_attachment" "sto-readonly-role-policy-attach" {
  role       = aws_iam_role.lambda_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  provider         = aws.us_east_1
}

resource "aws_lambda_function" "edge_headers" {
  filename         = "headers.zip"
  function_name    = "edge_headers"
  role             = aws_iam_role.lambda_service_role.arn
  handler          = "headers.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "nodejs10.x"
  publish          = true 
  provider         = aws.us_east_1
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.edge_headers.function_name
  principal     = "events.amazonaws.com"
  provider      = aws.us_east_1
}