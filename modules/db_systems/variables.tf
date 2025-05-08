# Variables for DB Connection and Security System

variable "system_name" {
  description = "Name of the security system"
  type        = string
}

variable "display_name" {
  description = "Display name for the security system"
  type        = string
}

variable "hostname" {
  description = "Host name for the security system"
  type        = string
}

variable "port" {
  description = "Port for the security system"
  type        = number
}

variable "access_add_workflow" {
  description = "Access add workflow name"
  type        = string
}

variable "connection_name" {
  description = "Name of the DB connection"
  type        = string
}

variable "db_type" {
  description = "Type of database"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "username" {
  description = "Database username"
  type        = string
}

variable "password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "endpoint_name" {
  description = "Endpoint name"
  type        = string
}

variable "endpoint_display_name" {
  description = "Display name for endpoint"
  type        = string
}
