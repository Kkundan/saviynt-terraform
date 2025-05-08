# Locals to prepare JSON templates and static values

locals {
  create_account_json = {
    CreateAccountQry = [
      "INSERT INTO mysqllocal.users(username, firstname, lastname, statuskey, departmentname, displayname, manager, enabled, updatedate) VALUES ('${user.username}', '${user.firstname}', '${user.lastname}', '${user.statuskey}', '${user.departmentname}', '${user.displayname}', '${user.manager}', '${user.enabled}', CURRENT_TIMESTAMP)",
      "INSERT INTO mysqllocal.accounts(AccountName, EntitlementType, EntitlementValue, Status, UPDATEDATE) VALUES ('${user.username}', 'DEFAULT', 'BASE_ACCESS', 1, CURRENT_TIMESTAMP)"
    ]
  }

  update_account_json = {
    UpdateAccountQry = [
      "UPDATE mysqllocal.users SET firstname =${user.firstname}, lastname = ${user.lastname}, departmentname = ${user.departmentname}, displayname = ${user.displayname}, manager = ${user.manager}, orgunitID = ${user.orgunitID}, updatedate = CURRENT_TIMESTAMP WHERE username = ${user.username}"
    ]
  }

  grant_access_json = {
    ENTITLEMENT_TYPE1 = [
      "INSERT INTO mysqllocal.accounts(AccountName, EntitlementType, EntitlementValue, Status, UPDATEDATE) VALUES(${user.username}, ${entitlement.type}, ${entitlement.value}, 1, CURRENT_TIMESTAMP)"
    ],
    ROLE_ACCESS = [
      "INSERT INTO mysqllocal.roles(role_name, description, displayname, status, updatedate) VALUES(${role.name}, ${role.description}, ${role.displayname}, 1, CURRENT_TIMESTAMP)"
    ]
  }

  revoke_access_json = {
    ENTITLEMENT_TYPE1 = [
      "UPDATE mysqllocal.accounts SET Status = 0, UPDATEDATE = CURRENT_TIMESTAMP WHERE AccountName = ${user.username} AND EntitlementType = ${entitlement.type} AND EntitlementValue = ${entitlement.value}"
    ]
  }

  change_pass_json = {
    ChangePasswordQry = [
      "UPDATE mysqllocal.users SET password = ${user.password}, updatedate = CURRENT_TIMESTAMP WHERE username = ${user.username}"
    ]
  }

  delete_account_json = {
    DeleteAccountQry = [
      "DELETE FROM mysqllocal.users WHERE username = ${user.username}",
      "DELETE FROM mysqllocal.accounts WHERE AccountName = ${user.username}"
    ]
  }

  enable_account_json = {
    EnableAccountQry = [
      "UPDATE mysqllocal.users SET enabled = 1, updatedate = CURRENT_TIMESTAMP WHERE username = ${user.username}",
      "UPDATE mysqllocal.accounts SET Status = 1, UPDATEDATE = CURRENT_TIMESTAMP WHERE AccountName = ${user.username}"
    ]
  }

  disable_account_json = {
    DisableAccountQry = [
      "UPDATE mysqllocal.users SET enabled = 0, updatedate = CURRENT_TIMESTAMP WHERE username = ${user.username}",
      "UPDATE mysqllocal.accounts SET Status = 0, UPDATEDATE = CURRENT_TIMESTAMP WHERE AccountName = ${user.username}"
    ]
  }

  account_exists_json = {
    AccountExistQry = "SELECT username FROM mysqllocal.users WHERE username = ${user.username}"
  }

  update_user_json = {
    UpdateUserQry = [
      "UPDATE mysqllocal.users SET firstname = ${user.firstname}, lastname = ${user.lastname}, departmentname = ${user.departmentname}, displayname = ${user.displayname}, manager = ${user.manager}, orgunitID = ${user.orgunitID}, updatedate = CURRENT_TIMESTAMP WHERE username =${user.username}"
    ]
  }
}
