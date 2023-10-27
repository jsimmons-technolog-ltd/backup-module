output "backup_vault_arn" {
  description = "ARN of the backup vault"
  value       = try(aws_backup_vault.this[0].arn)
}