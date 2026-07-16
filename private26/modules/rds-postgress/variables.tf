variable "create" {
  type        = bool
  default     = true
  description = "Whether to create the RDS instance and its supporting resources. Set to false to destroy them via a normal apply, without running terraform destroy."
}

variable "identifier" {
  type        = string
  description = "RDS instance identifier"
}

variable "engine" {
  type        = string
  description = "mysql | postgres | mariadb | oracle-* | sqlserver-*"
}

variable "engine_version" {
  type        = string
}

variable "parameter_group_family" {
  type        = string
  description = "RDS parameter group family (e.g. mysql8.0, postgres15)"
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "db_name" {
  type    = string
  default = null
}

variable "username" {
  type = string
}

variable "secret_name" {
  type        = string
  description = "Secrets Manager secret name for DB credentials"
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "port" {
  type        = number
  description = "Database port (5432 for PostgreSQL, 3306 for MySQL)"
  default     = 5432
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "deletion_protection" {
  type    = bool
  #default = true
}
variable "skip_final_snapshot" {
  type    = bool
  #default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
