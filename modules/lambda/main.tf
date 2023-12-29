data "archive_file" "my_first_lambda" {
  type        = "zip"
  source_file = "./modules/lambda/index.js"
  output_path = "my_first_lambda_payload.zip"
}

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0.0"

  function_name = var.function_name
  description   = "My first lambda function"
  handler       = "index.handler"
  runtime       = var.runtime
  publish       = true

  create_package         = false
  local_existing_package = "${path.module}/../../my_first_lambda_payload.zip"

  allowed_triggers = {
    cron_trigger = {
      principal  = "events.amazonaws.com"
      source_arn = var.rule_arn
    }
  }
}
