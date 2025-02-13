output "resource_group_id" {
  description = "The ID of the created Resource Group."
  value       = module.resource_group.resource_group_id
}

output "app_service_plan_id" {
  description = "The ID of the created App Service Plan."
  value       = module.app_service.app_service_plan_id
}

output "app_service_id" {
  description = "The ID of the created App Service."
  value       = module.app_service.app_service_id
}