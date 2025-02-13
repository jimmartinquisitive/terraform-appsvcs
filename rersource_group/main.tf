resource "azurerm_resource_group" "azResourceGroup" {
  name     = var.resource_group_name
  location = var.location
}