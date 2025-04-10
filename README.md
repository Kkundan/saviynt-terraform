# skeleton-terraform-project
This is a sample terraform project for integrating with Saviynt Identity Cloud.


---

##  Overview

With this sample project, you can:

- Get started with managing Saviynt Identity Cloud using the Saviynt Terraform provider.

---

##  Features

Following resources are available for management: 
- Security System
- Endpoint
- Connections

Following connectors are available:
- Active Directory(AD)
- REST
- ADSI
- Database(DB)
- EntraID(AzureAD)
- SAP
- Salesforce
- Workday
---

## Directory Structure
```
.
├── LICENSE
├── README.md
├── docs
│   ├── data-sources
│   │   ├── ad_connection_datasource.md
│   │   ├── adsi_connection_datasource.md
│   │   ├── connections_datasource.md
│   │   ├── db_connection_datasource.md
│   │   ├── endpoints_datasource.md
│   │   ├── entraid_connection_datasource.md
│   │   ├── rest_connection_datasource.md
│   │   ├── salesforce_connection_datasource.md
│   │   ├── sap_connection_datasource.md
│   │   ├── security_systems_datasource.md
│   │   └── workday_connection_datasource.md
│   ├── index.md
│   └── resources
│       ├── ad_connection_resource.md
│       ├── adsi_connection_resource.md
│       ├── db_connection_resource.md
│       ├── endpoint_resource.md
│       ├── entraid_connection_resource.md
│       ├── rest_connection_resource.md
│       ├── salesforce_connection_resource.md
│       ├── sap_connection_resource.md
│       ├── security_system_resource.md
│       └── workday_connection_resource.md
├── environment
│   ├── dev
│   │   ├── dev.tf
│   │   ├── dev.tfvars
│   │   └── variable.tf
│   ├── prod
│   │   ├── prod.tf
│   │   ├── prod.tfvars
│   │   └── variable.tf
│   └── test
│       ├── test.tf
│       ├── test.tfvars
│       └── variable.tf
├── provider
│   ├── terraform-provider-saviynt_0.1.3_darwin_amd64.zip
│   ├── terraform-provider-saviynt_0.1.3_darwin_arm64.zip
│   ├── terraform-provider-saviynt_0.1.3_linux_amd64.zip
│   ├── terraform-provider-saviynt_0.1.3_linux_arm64.zip
│   ├── terraform-provider-saviynt_0.1.3_windows_amd64.zip
│   └── terraform-provider-saviynt_0.1.3_windows_arm64.zip
├── provider.tf
└── resources
    ├── connections
    │   ├── ad_sample_connector.tf
    │   ├── adsi_sample_connector.tf
    │   ├── db_sample_connector.tf
    │   ├── rest_sample_connector.tf
    │   └── variables.tf
    ├── endpoints
    │   └── sample_endpoint.tf
    └── security_systems
        └── sample_security_system.tf

```

##  Requirements

- Terraform version `>= 1.8+`
- Go programming language `>= 1.21+` (required for development and contributions)
- Saviynt credentials (url, username and password)

---

## Getting started

Before installing the provider, ensure that you have the following dependencies installed:

### **1. Install Terraform**  
Terraform is required to use this provider. Install Terraform using one of the following methods:

#### **For macOS (using Homebrew)**
```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

#### **For Windows (using chocolatey)**
```sh
choco install terraform
```

#### **For Manual installation or other platforms**
Visit [Terraform Installation](https://developer.hashicorp.com/terraform/install) for installation instructions.

### 2. Install Go

#### **For macOS (using Homebrew)**
```sh
brew install go
```
#### **For Windows (using chocolatey)**
```sh
choco install golang
```
#### **For Manual installation or other platforms**
Visit [Go Setup](https://go.dev/doc/install) for installation instructions.

### 3. Finding the GOBIN Folder Path

#### **For macOS**

To check the `GOBIN` path, run the following command in your terminal:

```sh
go env GOBIN
```

If it doesn't return anything, Go will use the default: `$GOPATH/bin`.

To explicitly set `GOBIN`, you can update your shell configuration file (e.g., `~/.zshrc`, `~/.bashrc`, etc.). Below are steps for `~/.zshrc`:

1. Open the file in your default editor:
   ```sh
   open ~/.zshrc
   ```

2. Add the following lines at the end of the file:
   ```sh
   export GOBIN=$HOME/go/bin
   export PATH=$PATH:$GOBIN
   ```

3. Apply the changes:
   ```sh
   source ~/.zshrc
   ```

4. Confirm the value:
   ```sh
   go env GOBIN
   ```

You should now see the path as `$HOME/go/bin`.

---

#### **For Windows**

To check the current `GOBIN` value, run the following in **Command Prompt** or **PowerShell**:

```sh
go env GOBIN
```

If it's empty, Go defaults to `%GOPATH%\bin`. To check `GOPATH`, run:

```sh
go env GOPATH
```

> The default path is usually: `C:\Users\<YourUsername>\go\bin`

To explicitly set `GOBIN`, follow these steps:

1. Open the **Start Menu** and search for **"Environment Variables"**.
2. Click **"Edit the system environment variables"**.
3. In the **System Properties** window, click **"Environment Variables…"**.
4. Under **User variables**, click **"New…"** and enter:
   - **Variable name**: `GOBIN`
   - **Variable value**: `C:\Users\<YourUsername>\go\bin` (or your desired path)
5. Add `GOBIN` to your system `Path`:
   - Under **User variables**, select the `Path` variable and click **Edit**.
   - Click **New** and add: `C:\Users\<YourUsername>\go\bin`
6. Click **OK** to save and exit all dialogs.
7. Restart your terminal or system.

To verify:

```sh
go env GOBIN
```

You should now see the configured GOBIN path.


> **Note:** Save the GOBIN path for later use.


<!-- ### 4. Download the Binary
Copy the provider binary from provider directory to the Go bin directory: 

```sh
cp provider/terraform-provider-saviynt_v0.1.3 <GOBIN PATH>/terraform-provider-saviynt
chmod +x GOBIN/terraform-provider-saviynt

```
Replace `<GOBIN PATH>` with your actual GOBIN path where the go bin folder is located. -->

### 4. Download the Binary

Inside the `provider` directory, you will find multiple `.zip` files for different operating systems (e.g., macOS, Windows, Linux). Choose the appropriate binary for your OS, extract it, and copy the provider binary to your Go bin directory.

For example, on macOS

```sh
# Unzip the appropriate binary
unzip terraform-provider-saviynt_v0.1.3_darwin_amd64.zip -d provider/

# Copy the binary to your GOBIN directory
cp provider/terraform-provider-saviynt_v0.1.3 <GOBIN PATH>/terraform-provider-saviynt

# Make it executable
chmod +x <GOBIN PATH>/terraform-provider-saviynt
```

> **Note:** Replace `<GOBIN PATH>` with your actual GOBIN path. If you're unsure, run:
```sh
go env GOBIN
```

### - macOS Security Warning Workaround

When using the downloaded Terraform provider binary on macOS, you might encounter a security warning like:

> `"Apple is not able to verify that it is free from malware that could harm your Mac or compromise your privacy. Don’t open this unless you are certain it is from a trustworthy source.`

This happens because macOS restricts the execution of unsigned binaries.  
To work around this, you can follow either of the options below:

####  Option 1: Allow via System Settings

1. Try running the provider binary once to trigger the security warning.
2. Open **System Settings** → **Privacy & Security**.
3. Scroll down to the **Security** section.
4. You’ll see a message similar to:
   > `"terraform-provider-saviynt" was blocked from use because it is not from an identified developer.`
5. Click **"Allow Anyway"**.
6. Re-run your Terraform command.
7. If prompted again, click **"Open"** to allow execution.

####  Option 2: Allow via Terminal

You can also manually remove the quarantine attribute using the Terminal:

```sh
xattr -d com.apple.quarantine <path-to-binary>/terraform-provider-saviynt
```

### 5. Configure `.terraformrc` or `terraform.rc`

Create the file at:

- **macOS/Linux**: `~/.terraformrc`
- **Windows**: `%APPDATA%\terraform.rc`

```hcl
provider_installation {
  dev_overrides {
    "<PROVIDER SOURCE PATH>" = "<GOBIN PATH>"
  }
  direct {}
}
```

### 6. Getting Started with Terraform

Follow the steps below to start using the Saviynt Terraform Provider:

---

#### **Step 1: Create a Terraform Project Folder**

```sh
mkdir saviynt-terraform-demo
cd saviynt-terraform-demo
```

---

#### **Step 2: Initialize a Terraform Configuration File**

Create a file named `main.tf` and define your provider and resources:

````hcl
terraform {
  required_providers {
    saviynt = {
      source  = "<PROVIDER SOURCE PATH>"
      version = "1.0.0"
    }
  }
}

provider "saviynt" {
  server_url  = "YOUR_SAVIYNT_URL"
  username   = "YOUR_SAVIYNT_USERNAME"
  password   = "YOUR_SAVIYNT_PASSWORD"
}
````

Replace the `<PROVIDER SOURCE PATH>` with your provider path. The configuration should look similar to `registry.terraform.io/local/saviynt`.

---

#### **Step 3: Define Input Variables**

Create a file called `variables.tf` to declare your input variables:

```hcl
variable "server_url" {
  description = "Saviynt instance base URL"
  type        = string
}

variable "username" {
  description = "Username"
  type        = string
  sensitive   = true
}
```

> You can refer to a sample `variables.tf` file in the `resources/connections/` folder for guidance.

---

#### **Step 4: Create a `terraform.tfvars` File**

This file contains the actual values for the declared variables:

```hcl
server_url   = "https://your-saviynt-instance"
username = "<USERNAME>"
password = "<PASSWORD>
```

> This file is automatically used by Terraform during plan and apply.

You can also name the file `prod.tfvars`, `dev.tfvars`, etc. and explicitly reference it:

```sh
terraform apply -var-file="terraform.tfvars"
```

> Make sure to add `terraform.tfvars` to your `.gitignore` if it contains sensitive information:

```sh
echo "terraform.tfvars" >> .gitignore
```

**Important:** When using `tfvars`, you must refer to the variables using `var.<variable_name>` syntax in your `.tf` files.  
For example, in your provider configuration or resource definitions:

```hcl
provider "saviynt" {
  server_url = var.server_url
  username   = var.username
  password = var.password
}
```

---

#### **Step 5: Validate & Apply Configuration**

Validate the configuration:

```sh
terraform validate
```

Plan the changes:

```sh
terraform plan
```

Apply the changes:

```sh
terraform apply -var-file=terraform.tfvars
```

That's it! You've now set up and run your first configuration using the Saviynt Terraform Provider.





<!-- ### Terraform Configuration

```hcl
terraform {
  required_providers {
    saviynt = {
      source  = "<PROVIDER SOURCE PATH>"
      version = "1.0.0"
    }
  }
}

provider "saviynt" {
  server_url  = "YOUR_SAVIYNT_URL"
  username   = "YOUR_SAVIYNT_USERNAME"
  password   = "YOUR_SAVIYNT_PASSWORD"
}
```

Replace the `<PROVIDER SOURCE PATH>` with your provider path. The configuration should look similar to `registry.terraform.io/local/saviynt`. -->

---

##  Usage

Here's an example of defining and managing a resource:

```hcl
resource "saviynt_security_system_resource" "sample" {
  systemname          = "sample_security_system"
  display_name        = "sample security system"
  hostname            = "sample.system.com"
  port                = "443"
  access_add_workflow = "sample_workflow"
}
```
Here's an example of using the data source block:
```hcl
data "saviynt_security_systems_datasource" "all" {
  connection_type = "REST"
  max             = 10
  offset          = 0
}

output "systems" {
  value = data.saviynt_security_systems_datasource.all.results
}
```

You can find the starter templates to define each supported resource type in the resource folder. To know the differnt types of arguments that can be passed for each resource, user can refer to the ```docs/``` folder.

For inputs that require JSON config, you can give the values as in the given example:
```sh
create_account_json = jsonencode({
    "cn" : "$${cn}",
    "displayname" : "$${user.displayname}",
    "givenname" : "$${user.firstname}",
    "mail" : "$${user.email}",
    "name" : "$${user.displayname}",
    "objectClass" : ["top", "person", "organizationalPerson", "user"],
    "userAccountControl" : "544",
    "sAMAccountName" : "$${task.accountName}",
    "sn" : "$${user.lastname}",
    "title" : "$${user.title}"
  })
```
As in the above example, to pass special characters like `$`, we have to use `$$` instead and for json data, use the `jsonencode()` function to properly pass the data using terraform.

---

##  Available Resources

###  Resource

- [saviynt_security_system_resource](docs/resources/security_system_resource.md): Manages lifecycle (create, update, read) of security systems. Supports workflows, connectors, password policies and more.
- [saviynt_endpoints_resource](docs/resources/endpoint_resource.md): For managing endpoints definitions used by security systems.
- [saviynt_ad_connection_resource](docs/resources/ad_connection_resource.md): For managing AD connections.
- [saviynt_rest_connection_resource](docs/resources/rest_connection_resource.md): For managing REST connections.
- [saviynt_adsi_connection_resource](docs/resources/adsi_connection_resource.md): For managing ADSI connections.
- [saviynt_db_connection_resource](docs/resources/db_connection_resource.md): For managing DB connections.
- [saviynt_entraid_connection_resource](docs/resources/entraid_connection_resource.md): For managing EntraID(AzureAD) connections.
- [saviynt_sap_connection_resource](docs/resources/sap_connection_resource.md): For managing SAP connections.
- [saviynt_salesforce_connection_resource](docs/resources/salesforce_connection_resource.md): For managing Salesforce connections.
- [saviynt_workday_connection_resource](docs/resources/workday_connection_resource.md): For managing Workday connections.

###  Data Source

- [saviynt_security_systems_datasource](docs/data-sources/security_systems_datasource.md): Retrieves a list of configured security systems filtered by systemname, connection_type, etc.
- [saviynt_endpoint_datasource](docs/data-sources/endpoints_datasource.md): Retrieves a list of endpoints.
- [saviynt_connections_datasource](docs/data-sources/connections_datasource.md): Retrieves a list of connections
- [saviynt_ad_connection_datasource](docs/data-sources/ad_connection_datasource.md): Retrieves an AD connection
- [saviynt_rest_connection_datasource](docs/data-sources/rest_connection_datasource.md): Retrieves a REST connection
- [saviynt_entraid_connection_datasource](docs/data-sources/entraid_connection_datasource.md): Retrieves a EntraID(AzureAD) connection
- [saviynt_sap_connection_datasource](docs/data-sources/sap_connection_datasource.md): Retrieves a SAP connection
- [saviynt_salesforce_connection_datasource](docs/data-sources/salesforce_connection_datasource.md): Retrieves a Salesforce connection
- [saviynt_workday_connection_datasource](docs/data-sources/workday_connection_datasource.md): Retrieves a Workday connection



---

## Here are the Terraform commands to be run:

1. To initialise Terraform
```bash
terraform init
```

2. To plan the changes from the .tf file and .tfstate file
```bash
terraform plan
```

3. To apply the changes.
```bash
terraform apply
```

## Terraform Workspaces

1. To create a new workspace

```bash
terraform workspaces new <workspace-name>
```

2. To select a workspace

```bash
terraform workspaces select <workspace-name>
```

3. To apply changes to an environment
```bash
terraform apply -var-file="<values.tfvars>"
```

##### Here is a sample invocation example:
```bash
terraform apply -var-file="dev.tfvars"
```
---

##  License

This project is licensed under the Apache License 2.0. Refer to [LICENSE](LICENSE) for full license details.

---

##  Support

If you encounter any issues or have questions, please open an issue on our GitHub page.

---
