# Terraform Module: AWS Backup

This module is written and maintained by David Pritchett and the IT Dept.

## Contents

- [Example](#example)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Example

```hcl
module "aws-backup" = {
  vault_name  = "Billbury-Vault"
  plan_name   = "Dev-Plan"
  create_vault = true
  create_plan = true

  rules = [
    {
      rule_name         = "Rule1"
      schedule          = "cron(0 0 01 * * ?)"
      start_window      = 0
      completion_window = 0
      lifecycle = {
        cold_storage_after = 0
        delete_after       = 30
      }
      copy_action = {
        destination_vault = * destination vault arn *
        lifecycle = {
          cold_storage_after = 0
          delete_after       = 90
        } 
      }
    }
  ]

  selection_name  = "Nightly-Backups"
  selection_key   = "Backup"
  selection_value = "Nightly"
}
```

## Inputs

| Name | Description | Type | Default |
|:-----|:------------|:----:|:-------:|
| `create_vault` | Determines if a backup vault should be created | bool | true |
| `alternate_region_vault` | Determines if the vault created should be in your alternate region. A provider alias called \"backup-region\" must be created for the alternate region | bool | false |
| `create_plan` | Determines if a backup plan should be created | bool | true |
| `vault_name` | Name for the backup vault | string | null |
| `plan_name` | Name for the backup plan | string | null |
| `rules` | List containing backup rules | list(any) | [] |
| `rule_name` | The display name for the backup schedule | string | null |
| `schedule` | A CRON expression specifying when AWS Backup initiates a backup job | string | "cron(0 0 01 * * ?)" |
| `start_window` | The amount of time in minutes before beginning a backup | number | 0 |
| `completion_window` | The amount of time in minutes AWS Backup attempts a backup before canceling the job and returning an error | number | 480 |
| `cold_storage_after` | Specifies the number of days after creation that a recovery point is moved to cold storage | number | null |
| `delete_after` | Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than | number | 90 |
| `destination_vault` | ARN of the vault for the backups to be copied to | string | null |
| `selection_name` | Name for the backup selection | string | null |
| `selection_key` | The tag to be used to define is a resource as associated with the backup plan | string | null |
| `selection_value` | The value of the tag to associate with this backup plan | string | null |
| `tags` | A mapping of tags for the resource | map(string) | {} |

## Outputs

| Name | Description |
|:-----|:------------|
| `backup_vault_arn` | ARN of the backup vault |