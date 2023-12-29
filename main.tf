terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "ap-southeast-1"
  access_key = "AKIAYC3NRCBWXEV4SXGW"
  secret_key = "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"
}

module "my_lambda" {
  source        = "./modules/lambda"
  function_name = "my-first-lambda"
  runtime       = "nodejs18.x"
  rule_arn      =  module.my_eventbridge.rule_arn
}

module "my_eventbridge" {
  source              = "./modules/eventbridge"
  rule_name           = "everyday_cron"
  schedule_expression = "cron(0 22 * * ? *)" # Adjust the cron expression as needed
  lambda_arn          = module.my_lambda.lambda_arn
}
