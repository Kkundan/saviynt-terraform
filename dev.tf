terraform {
  required_providers {
    saviynt = {
      source  = "registry.terraform.io/local/saviynt"
      version = "1.0.0"
    }
  }
}

# 3. Instantiate DB modules
module "db_systems" {
  source = "./modules/db_systems"

  for_each = {
    for sys in local.db_systems_csv :
    sys.system_name => {
      display_name          = sys.display_name
      hostname              = sys.hostname
      port                  = tonumber(sys.port)
      access_add_workflow   = sys.access_add_workflow
      connection_name       = sys.connection_name
      db_type              = sys.db_type
      db_name              = sys.db_name
      username             = sys.username
      password             = sys.password
      endpoint_name        = sys.endpoint_name
      endpoint_display_name = sys.endpoint_display_name
    }
  }

  system_name           = each.key
  display_name          = each.value.display_name
  hostname              = each.value.hostname
  port                  = each.value.port
  access_add_workflow   = each.value.access_add_workflow
  connection_name       = each.value.connection_name
  db_type              = each.value.db_type
  db_name              = each.value.db_name
  username             = each.value.username
  password             = each.value.password
  endpoint_name        = each.value.endpoint_name
  endpoint_display_name = each.value.endpoint_display_name
}

provider "saviynt" {
  server_url = var.SAVIYNT_SERVER_URL
  username = var.SAVIYNT_USERNAME
  password = var.SAVIYNT_PASSWORD
}

# 1. Load CSV
locals {
  # Read and parse the CSV files
  ad_systems_csv = csvdecode(file("C:/Users/kunda/OneDrive/Documents/work/GitHub/saviynt-terraform/resources/ad_systems.csv"))
  db_systems_csv = csvdecode(file("C:/Users/kunda/OneDrive/Documents/work/GitHub/saviynt-terraform/resources/db_systems.csv"))

  # Transform AD systems into map
  ad_systems = {
    for sys in local.ad_systems_csv :
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

# 2. Instantiate AD modules
module "ad_systems" {
  for_each = local.ad_systems

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
