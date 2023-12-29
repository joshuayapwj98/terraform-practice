module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"

  create_bus     = false
  create_targets = false
  create_role       = true
  role_name         = "eventbridge-${var.rule_name}"

  rules = {
    cron = {
      name                = var.rule_name
      description         = "invoke a lambda function everyday"
      schedule_expression = var.schedule_expression
    }
  }

  targets = {
    cron = [
      {
        name  = "${var.rule_name}-target"
        arn   = var.lambda_arn
        input = jsonencode({ "job" : "cron-by-rate" })
      }
    ]
  }
}
# resource "aws_cloudwatch_event_rule" "my_eventbridge_rule" {
#   name                = var.rule_name
#   description         = "Trigger my_lambda_function at specified schedule"
#   schedule_expression = var.schedule_expression
# }

# resource "aws_cloudwatch_event_target" "my_lambda_target" {
#   rule      = aws_cloudwatch_event_rule.my_eventbridge_rule.name
#   target_id = "my-lambda-target"
#   arn       = var.lambda_arn
# }
