variable "create_vault" {
  description = "Determines if a backup vault should be created"
  type        = bool
  default     = true
}

variable "create_plan" {
  description = "Determines if a backup plan should be created"
  type        = bool
  default     = true
}

variable "vault_name" {
  description = "Name for the backup vault"
  type        = string
  default     = null
}

variable "plan_name" {
  description = "Name for the backup plan"
  type        = string
  default     = null
}

variable "rules" {
  description = "List containing backup rules"
  type        = list(any)
  default     = []
}

variable "rule_name" {
  description = "The display name for the backup schedule"
  type        = string
  default     = null
}

variable "schedule" {
  description = "A CRON expression specifying when AWS Backup initiates a backup job"
  type        = string
  default     = "cron(0 0 01 * * ?)"
}

variable "start_window" {
  description = "The amount of time in minutes before beginning a backup"
  type        = number
  default     = 0
}

variable "completion_window" {
  description = "The amount of time in minutes AWS Backup attempts a backup before canceling the job and returning an error"
  type        = number
  default     = 480
}

variable "cold_storage_after" {
  description = "Specifies the number of days after creation that a recovery point is moved to cold storage"
  type        = number
  default     = null
}

variable "delete_after" {
  description = "Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than"
  type        = number
  default     = 90
}

variable "destination_vault" {
  description = "ARN of the vault for the backups to be copied to"
  type        = string
  default     = null
}

variable "selection_name" {
  description = "Name for the backup selection"
  type        = string
  default     = null
}

variable "selection_key" {
  description = "The tag to be used to define is a resource as associated with the backup plan"
  type        = string
  default     = null
}

variable "selection_value" {
  description = "The value of the tag to associate with this backup plan"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags for the resource"
  type        = map(string)
  default     = {}
}
