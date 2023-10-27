resource "aws_backup_vault" "this" {
  provider = aws.backup-region #var.alternate_region_vault ? aws.backup-region : aws
  count    = var.create_vault ? 1 : 0
  name     = var.vault_name

  tags = var.tags
}

resource "aws_backup_plan" "this" {
  count = var.create_plan ? 1 : 0
  name  = var.plan_name

  dynamic "rule" {
    for_each = length(var.rules) > 0 ? var.rules : []
    content {
      rule_name         = lookup(rule.value, "rule_name", null)
      target_vault_name = aws_backup_vault.this[0].name
      schedule          = lookup(rule.value, "schedule", null)
      start_window      = lookup(rule.value, "start_window", null)
      completion_window = lookup(rule.value, "completion_window", null)

      dynamic "lifecycle" {
        for_each = lookup(rule.value, "lifecycle", null) != null ? [true] : []
        content {
          cold_storage_after = lookup(rule.value.lifecycle, "cold_storage_after", null)
          delete_after       = lookup(rule.value.lifecycle, "delete_after", null)
        }
      }

      dynamic "copy_action" {
        for_each = try(lookup(rule.value.copy_action, "destination_vault", null), null) != null ? [true] : []
        content {
          destination_vault_arn = lookup(rule.value.copy_action, "destination_vault", null)

          dynamic "lifecycle" {
            for_each = lookup(rule.value.copy_action, "lifecylce", null) != null ? [true] : []
            content {
              cold_storage_after = lookup(rule.value.copy_action.lifecycle, "cold_storage_after", null)
              delete_after       = lookup(rule.value.copy_action.lifecycle, "delete_after", null)
            }
          }
        }
      }
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "enabled"
    }
    resource_type = "EC2"
  }

  tags = var.tags
}

resource "aws_backup_selection" "this" {
  count = var.create_plan ? 1 : 0

  iam_role_arn = aws_iam_role.this.arn
  name         = var.selection_name
  plan_id      = var.create_plan ? aws_backup_plan.this[0].id : ""

  selection_tag {
    type  = "STRINGEQUALS"
    key   = var.selection_key
    value = var.selection_value
  }
}