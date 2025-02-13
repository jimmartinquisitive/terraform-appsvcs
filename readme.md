# Terraform Module: App Service & App Service Plan in an ASE

This module creates an Azure App Service Plan and an App Service within an existing App Service Environment (ASE). It is designed for deployment via Azure DevOps pipelines.

## Usage Example

```hcl
module "app_service" {
  source = "./terraform-app-service"

  resource_group_name         = "my-resource-group"
  location                    = "eastus"
  ase_id                      = "/subscriptions/<subscription_id>/resourceGroups/<rg_name>/providers/Microsoft.Web/hostingEnvironments/<ase_name>"
  app_service_plan_name       = "my-app-service-plan"
  app_service_plan_sku_tier   = "Isolated"  # Ensure the tier is appropriate for ASEs
  app_service_plan_sku_size   = "I1"
  app_service_name            = "my-app-service"
  app_service_settings        = {
    "SETTING_KEY" = "setting_value"
  }
}

Variables
resource_group_name: The resource group for the deployment.
location: Azure region.
ase_id: The resource ID of the existing App Service Environment.
app_service_plan_name: Name for the App Service Plan.
app_service_plan_sku_tier: SKU tier (default: Isolated).
app_service_plan_sku_size: SKU size (default: I1).
app_service_kind: Kind of the App Service (default: app).
app_service_name: Name for the App Service.
app_service_settings: Map of application settings for the App Service.
Outputs
app_service_plan_id: The ID of the created App Service Plan.
app_service_id: The ID of the created App Service.