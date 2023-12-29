variable "rule_name" {
  description = "The name of the EventBridge rule"
}

variable "schedule_expression" {
  description = "The schedule expression for the EventBridge rule"
}

variable "lambda_arn" {
  description = "The ARN of the Lambda function"
}