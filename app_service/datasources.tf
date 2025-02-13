data "azurerm_app_service_plan" "azAppServicePlan" {
  name                = var.app_service_plan_name
  resource_group_name = var.app_service_plan_resource_group
}