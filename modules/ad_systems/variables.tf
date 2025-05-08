# Variables for AD Connection and Security System

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
  description = "Name of the AD connection"
  type        = string
}

variable "ldap_protocol" {
  description = "LDAP protocol to use (ldap or ldaps)"
  type        = string
}

variable "ip_address" {
  description = "IP address of the LDAP server"
  type        = string
}

variable "ldap_port" {
  description = "LDAP port"
  type        = number
}

variable "bind_user" {
  description = "LDAP bind user"
  type        = string
}

variable "password" {
  description = "LDAP bind user password"
  type        = string
  sensitive   = true
}

variable "base_container" {
  description = "Base container DN for LDAP operations"
  type        = string
}

variable "endpoint_name" {
  description = "Endpoint name"
  type        = string
}

variable "endpoint_display_name" {
  description = "Display name for endpoint"
  type        = string
}
