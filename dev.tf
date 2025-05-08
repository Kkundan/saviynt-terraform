terraform {
  required_providers {
    saviynt = {
      source  = "registry.terraform.io/local/saviynt"
      version = "1.0.0"
    }
  }
}

provider "saviynt" {
  server_url = var.SAVIYNT_SERVER_URL
  username = var.SAVIYNT_USERNAME
  password = var.SAVIYNT_PASSWORD
}

# 1. Load CSV
locals {
  # Read and parse the CSV file
  systems_csv = csvdecode(file("C:/Users/kunda/OneDrive/Documents/work/GitHub/saviynt-terraform/resources/ad_systems.csv"))

  # Transform into map with system name as key
  systems = {
    for sys in local.systems_csv :
    sys.system_name => {
      display_name          = sys.display_name
      hostname              = sys.hostname
      port                  = tonumber(sys.port)
      access_add_workflow   = sys.access_add_workflow
      connection_name       = sys.connection_name
      ldap_protocol         = sys.ldap_protocol
      ip_address            = sys.ip_address
      ldap_port             = tonumber(sys.ldap_port)
      bind_user             = sys.bind_user
      password              = sys.password
      base_container        = sys.base_container
      endpoint_name         = sys.endpoint_name
      endpoint_display_name = sys.endpoint_display_name
    }
  }
}

# 2. Instantiate modules dynamically based on type
module "ad_systems" {

  for_each = local.systems

  source = "./modules/ad_systems"  # wherever your module is

  system_name           = each.key
  display_name          = each.value.display_name
  hostname              = each.value.hostname
  port                  = each.value.port
  access_add_workflow   = each.value.access_add_workflow

  connection_name       = each.value.connection_name
  ldap_protocol         = each.value.ldap_protocol
  ip_address            = each.value.ip_address
  ldap_port             = each.value.ldap_port
  bind_user             = each.value.bind_user
  password              = each.value.password
  base_container        = each.value.base_container

  endpoint_name         = each.value.endpoint_name
  endpoint_display_name = each.value.endpoint_display_name
}