output "app_service_id" {
  description = "The ID of the App Service."
  value       = azurerm_app_service.azAppService.id
}