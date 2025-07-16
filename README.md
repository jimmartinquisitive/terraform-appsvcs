# terraform-appsvcs

This repository contains a set of reusable Terraform modules to provision a comprehensive Azure App Service environment. It simplifies the deployment of an Azure Resource Group, an App Service Plan, and an App Service, making it ideal for standardized application hosting on Azure.

The modules are designed to be flexible, supporting deployment into a standard multi-tenant environment or a dedicated App Service Environment (ASE).

## Features

-   **Modular Design:** Resources are split into logical, reusable modules (`resource_group`, `app_service_plan`, `app_service`).
-   **Resource Provisioning:** Creates an Azure Resource Group, App Service Plan, and App Service.
-   **Configurable Plan:** Easily configure the SKU (Tier and Size) for the App Service Plan.
-   **ASE Support:** Ready for deployment into an existing App Service Environment by providing the `app_service_environment_id`.
-   **Custom App Settings:** Pass a map of key-value pairs to configure application settings.
-   **CI/CD Ready:** Includes an example Azure DevOps YAML pipeline (`pipeline.yaml`) demonstrating a multi-stage deployment workflow (Dev/Test/Prod) with manual approvals.

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

-   [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) (version >= 1.3.0)
-   [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
-   An active Azure subscription with permissions to create the resources.

### Installation & Setup

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/your-username/terraform-appsvcs.git
    cd terraform-appsvcs
    ```

2.  **Authenticate with Azure:**
    Log in to your Azure account and set the desired subscription.
    ```sh
    az login
    az account set --subscription "Your Subscription Name or ID"
    ```

3.  **Configure Variables:**
    Create a `terraform.tfvars` file in the root directory. This file will contain the specific values for your deployment. Use the provided `.tfvars` file as a template.

    **`terraform.tfvars` example:**
    ```hcl
    resource_group_name           = "rg-myapp-prod-eus"
    location                      = "East US"
    app_service_plan_name         = "asp-myapp-prod-eus"
    app_service_plan_sku_tier     = "Isolated"
    app_service_plan_sku_size     = "I1"
    app_service_name              = "app-myapp-prod-eus"
    app_service_settings          = {
      "WEBSITE_NODE_DEFAULT_VERSION" = "18-lts"
      "FRAMEWORK"                    = "Node.js"
    }
    # To deploy into an ASE, uncomment and provide the ID:
    # app_service_environment_id = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Web/hostingEnvironments/..."
    ```

4.  **Initialize Terraform:**
    Download the required providers and initialize the backend.
    ```sh
    terraform init
    ```

## Usage

Once the prerequisites and setup are complete, you can deploy the infrastructure using the standard Terraform workflow.

1.  **Generate an Execution Plan:**
    Review the changes that Terraform will make.
    ```sh
    terraform plan -out=tfplan
    ```

2.  **Apply the Configuration:**
    Create the resources in Azure.
    ```sh
    terraform apply "tfplan"
    ```

### Module Usage Example

While this repository can be run directly, the modules are designed to be called from a parent Terraform configuration. Here is an example of how you might call the root module:

```hcl
# main.tf in your own project
module "app_service_stack" {
  source = "github.com/your-username/terraform-appsvcs" # Or a local path

  resource_group_name           = "rg-myapp-prod-eus"
  location                      = "East US"
  app_service_plan_name         = "asp-myapp-prod-eus"
  app_service_name              = "app-myapp-prod-eus"

  # Optional: Customize the App Service Plan SKU
  app_service_plan_sku_tier     = "Isolated"
  app_service_plan_sku_size     = "I1"

  # Optional: Add application settings
  app_service_settings = {
    "SETTING_1" = "VALUE_1"
    "SETTING_2" = "VALUE_2"
  }

  # Optional: Link to an App Service Environment
  # app_service_environment_id = var.my_ase_id
}

output "app_service_id" {
  description = "The ID of the deployed App Service."
  value       = module.app_service_stack.app_service_id
}
```

### Azure DevOps Pipeline

An example `pipeline.yaml` is included to demonstrate how to automate the deployment of this infrastructure across multiple environments (Dev, Test, Prod) using Azure DevOps.

**Key features of the pipeline:**
*   **Multi-Stage:** Defines separate stages for Dev, Test, and Prod.
*   **Manual Approvals:** Includes `ManualValidation` tasks to gate deployments to Test and Prod environments, ensuring a human review occurs.
*   **Environment-Specific Variables:** Uses different backend configurations (`-backend-config`) and variable files (`-var-file`) for each stage, allowing for environment-specific settings.

To use this pipeline, you will need to set up the corresponding backend configuration files (e.g., `dev.backend.config`) and variable files (e.g., `dev.tfvars`) for each of your environments.

## Inputs

The following input variables are configurable for the root module:

| Name                              | Description                                                              | Type          | Default    | Required |
| --------------------------------- | ------------------------------------------------------------------------ | ------------- | ---------- | :------: |
| `resource_group_name`             | The name of the resource group where the resources will be deployed.     | `string`      | n/a        |   yes    |
| `location`                        | The Azure region in which to deploy the resources.                       | `string`      | n/a        |   yes    |
| `app_service_plan_name`           | The name of the App Service Plan to create.                              | `string`      | n/a        |   yes    |
| `app_service_plan_resource_group` | The resource group name for the App Service Plan, if it already exists.  | `string`      | n/a        |   yes    |
| `app_service_name`                | The name of the App Service to create.                                   | `string`      | n/a        |   yes    |
| `app_service_plan_sku_tier`       | The SKU tier for the App Service Plan.                                   | `string`      | `"Isolated"` |    no    |
| `app_service_plan_sku_size`       | The SKU size for the App Service Plan.                                   | `string`      | `"I1"`     |    no    |
| `app_service_kind`                | The kind of the App Service. Typically, use 'app'.                       | `string`      | `"app"`      |    no    |
| `app_service_reserved`            | Must be `true` for Linux plans.                                          | `string`      | `"true"`   |    no    |
| `maximum_elastic_worker_count`    | Optional: configure scaling options.                                     | `string`      | `"1"`      |    no    |
| `app_service_settings`            | A map of App Service application settings.                               | `map(string)` | `{}`       |    no    |
| `app_service_environment_id`      | ID of the App Service Environment (if applicable).                       | `string`      | `""`       |    no    |

## Outputs

The following outputs are exported by the root module:

| Name                  | Description                          |
| --------------------- | ------------------------------------ |
| `resource_group_id`   | The ID of the created Resource Group.  |
| `app_service_plan_id` | The ID of the created App Service Plan. |
| `app_service_id`      | The ID of the created App Service.     |

## File Structure

The repository is organized into a modular structure:

```
.
├── modules/
│   ├── app_service/          # Module for the Azure App Service
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── app_service_plan/     # Module for the Azure App Service Plan
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── resource_group/       # Module for the Azure Resource Group
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── .tfvars                   # Example variable definitions
├── main.tf                   # Root module composition
├── variables.tf              # Root module variable definitions
├── outputs.tf                # Root module outputs
└── pipeline.yaml             # Example Azure DevOps CI/CD pipeline
```