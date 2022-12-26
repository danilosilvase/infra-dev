variable "name" {
  type        = string
  default     = "hml-database"
  description = "value"
}

variable "subnet_ids" {
  type        = list(string)
  description = "value"
}

variable "vpc_id" {
  type        = string
  description = "value"
}

# variable "password" {
#   type        = string
#   description = "value"
#   sensitive   = true
# }

variable "instance_class" {
  type        = string
  default     = "db.t3.xlarge"
  description = "Instance type for Database"
}

variable "engine_name" {
  description = "Specifies the name of the engine that this option group should be associated with"
  type        = string
  default     = "sqlserver-se"
}

variable "major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = "15.00"
}

variable "allocated_storage" {
  description = "Specifies the size of the disk for the rds instance"
  type        = string
  default     = 99
}

variable "db_subnet_group_name" {
  description = "Specifies subnet group name"
  type        = string
}

variable "create_subnet_group_name" {
  description = "Specifies subnet group name"
  type        = bool
  default     = true
}
