locals {
  rules = {
    prod = [
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

    dev = [
      {
        rule_name         = "nightly-backups"
        schedule          = "cron(0 1 * * ? *)"
        start_window      = 60
        completion_window = 480

        lifecycle = {
          delete_after = 32
        }
      }
    ]

    custom = var.rules
  }
}