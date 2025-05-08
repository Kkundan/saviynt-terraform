
terraform {
  required_providers {
    saviynt = {
      source  = "registry.terraform.io/local/saviynt"
      version = "1.0.0"
    }
  }
}

resource "saviynt_ad_connection_resource" "this" {
  connection_type = "AD"
  connection_name = var.connection_name
  url             = format("%s://%s:%d", var.ldap_protocol, var.ip_address, var.ldap_port)
  password        = var.password
  username        = var.bind_user
  searchfilter    = var.base_container

  create_account_json         = jsonencode(local.create_account_json)
  objectfilter                = replace(jsonencode(local.objectfilter_json), "\\u0026", "&")
  status_threshold_config     = jsonencode(local.status_threshold_config)
  entitlement_attribute       = "memberOf"
  group_search_base_dn         = var.base_container
  page_size                    = "1000"
  base                         = var.base_container
  account_name_rule            = format(
    "CN=task.accountName,%s###CN=task.accountName1,%s###CN=task.accountName2,%s",
    var.base_container, var.base_container, var.base_container
  )
  set_random_password          = "false"
  reuse_inactive_account       = "false"
  check_for_unique             = replace(jsonencode(local.check_for_unique), "\\u0026", "&")
  reset_and_change_passwrd_json = jsonencode(local.reset_and_change_password_json)
  unlock_account_json          = jsonencode(local.unlock_account_json)

  account_attribute = "[customproperty1::cn#String,customproperty30::userAccountControl#String,customproperty2::userPrincipalName#String,customproperty28::primaryGroupID#String,lastlogondate::lastLogon#millisec,displayname::name#String,customproperty25::company#String,customproperty20::employeeID#String,customproperty3::sn#String,comments::distinguishedName#String,customproperty4::homeDirectory#String,lastpasswordchange::pwdLastSet#millisec,customproperty5::co#String,customproperty6::employeeNumber#String,customproperty7::givenName#String,customproperty8::title#String,customproperty9::telephoneNumber#String,customproperty10::c#String,description::description#String,customproperty11::uSNCreated#String,validthrough::accountExpires#millisec,customproperty12::logonCount#String,customproperty13::physicalDeliveryOfficeName#String,updatedate::whenChanged#date,customproperty14::extensionAttribute1#String,customproperty15::extensionAttribute2#String,customproperty16::streetAddress#String,customproperty17::mailNickname#String,customproperty18::department#String,customproperty19::countryCode#String,name::sAMAccountName#String,customproperty21::manager#String,customproperty22::homePhone#String,customproperty23::mobile#String,created_on::whenCreated#date,accountclass::objectClass#String,accountid::objectGUID#Binary,customproperty24::userAccountControl#String,customproperty27::objectSid#Binary,RECONCILATION_FIELD::customproperty26,customproperty26::objectGUID#Binary,customproperty29::st#String]"
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
  endpointname     = var.endpoint_name
  display_name     = var.endpoint_display_name
  security_system  = var.system_name
}
