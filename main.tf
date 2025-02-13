provider "azurerm" {
  features {}
}

# Create Resource Group
module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

# Create App Service and App Service Plan
module "app_service_plan" {
  source = "./modules/app_service_plan"

  app_service_plan_name           = var.app_service_plan_name
  app_service_plan_resource_group = var.app_service_plan_resource_group
  app_service_plan_sku_tier       = var.app_service_plan_sku_tier
  app_service_plan_sku_size       = var.app_service_plan_sku_size
  app_service_kind                = var.app_service_kind
  app_service_reserved            = var.app_service_reserved
  maximum_elastic_worker_count    = var.maximum_elastic_worker_count
  
  # If applicable, pass app_service_environment_id:
   app_service_environment_id = var.app_service_environment_id
}

module "app_service" {
  source = "./modules/app_service"

  app_service_name                = var.app_service_name
  app_service_settings            = var.app_service_settings
  
  # If applicable, pass app_service_environment_id:
   app_service_environment_id = var.app_service_environment_id
}