terraform {
  required_providers {
    saviynt = {
      source  = "registry.terraform.io/local/saviynt"
      version = "1.0.0"
    }
  }
}

provider "saviynt" {
  server_url      = var.SAVIYNT_SERVER_URL
  username = var.SAVIYNT_USERNAME
  password = var.SAVIYNT_PASSWORD
}

resource "saviynt_ad_connection_resource" "sample" {
  connection_type         = "AD"
  connection_name         = "YOUR_CONNECTION_NAME"
  url                     = format("%s://%s:%d","ldaps", "127.0.0.1", "363")
  password                = "test@123"
  username                = "testadmin"
  ldap_or_ad              = "AD"
  base                    = "ou=users,dc=example,dc=com"
}
