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

variable "data_source_type" {
  description = "Type of data source to use (csv or json)"
  type        = string
  default     = "csv"
}

# Load data based on source type
locals {
  # Read the appropriate data source
  ad_systems_data = var.data_source_type == "csv" ? csvdecode(file("${path.module}/resources/ad_systems.csv")) : jsondecode(file("${path.module}/resources/ad_systems.json")).ad_systems
  db_systems_csv = csvdecode(file("${path.module}/resources/db_systems.csv"))

  # Transform AD systems into map
  ad_systems = {
    for sys in local.ad_systems_data :
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
