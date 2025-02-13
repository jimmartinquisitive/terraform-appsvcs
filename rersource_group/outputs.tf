output "resource_group_id" {
  description = "The ID of the created Resource Group."
  value       = azurerm_resource_group.azResourceGroup.id
}

output "resource_group_name" {
  description = "The name of the created Resource Group."
  value       = azurerm_resource_group.azResourceGroup.name
}

output "resource_group_location" {
  description = "The location of the created Resource Group."
  value       = azurerm_resource_group.azResourceGroup.location
}