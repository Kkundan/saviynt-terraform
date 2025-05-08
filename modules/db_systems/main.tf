terraform {
  required_providers {
    saviynt = {
      source  = "registry.terraform.io/local/saviynt"
      version = "1.0.0"
    }
  }
}

resource "saviynt_db_connection_resource" "this" {
  connection_type = "DB"
  connection_name = var.connection_name
  db_type        = var.db_type
  db_name        = var.db_name
  hostname       = var.hostname
  port           = var.port
  username       = var.username
  password       = var.password
}

# Create the Security System
resource "saviynt_security_system_resource" "this" {
  systemname          = var.system_name
  display_name        = var.display_name
  hostname            = var.hostname
  port                = var.port
  access_add_workflow = var.access_add_workflow
}

# Create the Endpoint
resource "saviynt_endpoint_resource" "this" {
  endpointname    = var.endpoint_name
  display_name    = var.endpoint_display_name
  security_system = var.system_name
}
