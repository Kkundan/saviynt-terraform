terraform {
  required_providers {
    saviynt = {
      source  = "registry.terraform.io/local/saviynt"
      version = "1.0.0"
    }
  }
}

resource "saviynt_db_connection_resource" "this" {
  connection_type        = "DB"
  connection_name        = var.connection_name
  db_type               = var.db_type
  db_name               = var.db_name
  hostname              = var.hostname
  port                  = var.port
  username              = var.username
  password              = var.password
  driver_name           = "com.mysql.jdbc.Driver"
  create_account_json   = jsonencode(local.create_account_json)
  update_account_json   = jsonencode(local.update_account_json)
  grant_access_json     = jsonencode(local.grant_access_json)
  revoke_access_json    = jsonencode(local.revoke_access_json)
  change_pass_json      = jsonencode(local.change_pass_json)
  delete_account_json   = jsonencode(local.delete_account_json)
  enable_account_json   = jsonencode(local.enable_account_json)
  disable_account_json  = jsonencode(local.disable_account_json)
  account_exists_json   = jsonencode(local.account_exists_json)
  update_user_json      = jsonencode(local.update_user_json)
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
