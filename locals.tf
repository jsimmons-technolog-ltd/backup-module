locals {
  prod_rules = [
    {
      rule_name         = "nightly-backups"
      schedule          = "cron(0 1 * * ? *)"
      start_window      = 60
      completion_window = 480

      lifecycle = {
        delete_after = 32
      }
    },
    {
      rule_name         = "monthly-backups"
      schedule          = "cron(0 1 1 * ? *)"
      start_window      = 60
      completion_window = 480

      lifecycle = {
        delete_after = 395
      }

      copy_actions = {
        destination_vault_arn = var.destination_vault

        lifecycle = {
          delete_after = 395
        }
      }
    },
    {
      rule_name         = "yearly-backups"
      schedule          = "cron(0 1 1 1 ? *)"
      start_window      = 60
      completion_window = 480

      lifecycle = {
        delete_after = 2555
      }

      copy_actions = {
        destination_vault_arn = var.destination_vault

        lifecycle = {
          delete_after = 2555
        }
      }
    }
  ]

  dev_rules = []

  prod_default = var.plan_name == "prod" ? local.prod_rules : null
  dev_default  = var.plan_name == "dev" ? local.dev_rules : null
  custom       = var.plan_name != "dev" || var.plan_name != "prod" ? var.rules : null
  rules        = coalesce(local.prod_default, local.dev_default, local.custom)
}