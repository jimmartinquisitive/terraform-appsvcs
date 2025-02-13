# Create the App Service Plan
resource "azurerm_app_service_plan" "azAppServicePlan" {
  name                = var.app_service_plan_name
  location            = resource_group.location
  resource_group_name = resource_group.name
  kind                = var.app_service_kind
  reserved            = var.app_service_reserved

  sku {
    tier = var.app_service_plan_sku_tier
    size = var.app_service_plan_sku_size
  }

  maximum_elastic_worker_count = var.maximum_elastic_worker_count

  # This property links the plan to your existing App Service Environment
   app_service_environment_id = var.app_service_environment_id
}
