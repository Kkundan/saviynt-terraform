# Locals to prepare JSON templates and static values

locals {
  create_account_json = {
    cn              = "$${cn}"
    displayname     = "$${user.displayname}"
    givenname       = "$${user.firstname}"
    mail            = "$${user.email}"
    name            = "$${user.displayname}"
    objectClass     = ["top", "person", "organizationalPerson", "user"]
    userAccountControl = "544"
    sAMAccountName  = "$${task.accountName}"
    sn              = "$${user.lastname}"
    title           = "$${user.title}"
  }

  objectfilter_json = {
    full         = "(&(objectCategory=person)(objectClass=user)(sAMAccountName=*))"
    incremental  = "(&(objectCategory=person)(objectClass=user)(sAMAccountName=*))"
  }

  status_threshold_config = {
    statusAndThresholdConfig = {
      statusColumn                = "customproperty30"
      activeStatus                = ["512", "544", "66048"]
      inactiveStatus              = ["546", "514", "66050"]
      deleteLinks                 = false
      accountThresholdValue       = 1000
      correlateInactiveAccounts   = true
      inactivateAccountsNotInFile = false
    }
  }

  check_for_unique = {
    userAccountCorrelationRule = "(&(objectCategory=person)(objectClass=user)(sAMAccountName=*))"
  }

  reset_and_change_password_json = {
    RESET  = { pwdLastSet = "0", title = "password reset" }
    CHANGE = { pwdLastSet = "-1", lockoutTime = 0, title = "password changed" }
  }

  unlock_account_json = {
    lockoutTime = "0"
  }
}
