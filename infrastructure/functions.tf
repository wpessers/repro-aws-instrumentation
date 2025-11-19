
# ======================================================================
# Infra to create the lambda function with broken instrumentation layer
# ======================================================================

module "broken_function" {
  source = "./modules/otel-lambda"

  name     = "broken-function"
  filename = "../lambda.zip"
  handler  = "index.handler"

  instrumentation_layer_arn = aws_lambda_layer_version.new_otel_layer.arn
}

data "aws_iam_policy_document" "broken_function_policy" {
  statement {
    effect    = "Allow"
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["${module.broken_function.log_group_arn}:*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "dynamodb:PutItem"
    ]
    resources = [aws_dynamodb_table.hello_world.arn]
  }
}

resource "aws_iam_role_policy" "broken_function_role_policy" {
  name   = "working-function-lambda-policy"
  policy = data.aws_iam_policy_document.broken_function_policy.json
  role   = module.broken_function.execution_role_id
}

# ============================================================================
# Infra to create the lambda function with old, working instrumentation layer
# ============================================================================

module "working_function" {
  source = "./modules/otel-lambda"

  name     = "working-function"
  filename = "../lambda.zip"
  handler  = "index.handler"

  enabled_instrumentations = "undici"

  instrumentation_layer_arn = aws_lambda_layer_version.old_otel_layer.arn
}

data "aws_iam_policy_document" "working_function_policy" {
  statement {
    effect    = "Allow"
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["${module.working_function.log_group_arn}:*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "dynamodb:PutItem"
    ]
    resources = [aws_dynamodb_table.hello_world.arn]
  }
}

resource "aws_iam_role_policy" "working_function_role_policy" {
  name   = "working-function-lambda-policy"
  policy = data.aws_iam_policy_document.working_function_policy.json
  role   = module.working_function.execution_role_id
}
