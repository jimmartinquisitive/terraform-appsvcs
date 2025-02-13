# Create the App Service
resource "azurerm_app_service" "azAppService" {
  name                = var.app_service_name
  location            = resource_group.location
  resource_group_name = module.resource_group.name
  app_service_plan_id = azurerm_app_service_plan.azurerm_app_service_plan.id

  app_settings = var.app_service_settings
}