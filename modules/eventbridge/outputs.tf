output "rule_arn" {
  value = module.eventbridge.eventbridge_rule_arns["cron"]
}

