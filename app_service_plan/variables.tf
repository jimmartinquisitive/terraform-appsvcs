variable "resource_group_name" {
  description = "The name of the resource group where the resources will be deployed."
  type        = string
}

variable "location" {
  description = "The Azure region in which to deploy the resources."
  type        = string
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan to create."
  type        = string
}

variable "app_service_plan_resource_group" {
  description = "The name of the resource group for the existing App Service Plan lookup (if applicable)."
  type        = string
}

variable "app_service_plan_sku_tier" {
  description = "The SKU tier for the App Service Plan (e.g., 'Isolated' for ASE deployments)."
  type        = string
  default     = "Isolated"
}

variable "app_service_plan_sku_size" {
  description = "The SKU size for the App Service Plan (e.g., 'I1', 'I2', 'I3')."
  type        = string
  default     = "I1"
}

variable "app_service_kind" {
  description = "The kind of the App Service. Typically, use 'app'."
  type        = string
  default     = "app"
}

variable "app_service_reserved" {
  description = "Must be true for Linux plans."
  type        = string
  default     = "true"
}

variable "maximum_elastic_worker_count" {
  description = "Optional: configure scaling options"
  type        = string
  default     = "1"
}

variable "app_service_name" {
  description = "The name of the App Service to create."
  type        = string
}

variable "app_service_settings" {
  description = "A map of App Service application settings."
  type        = map(string)
  default     = {}
}

# Uncomment if using an App Service Environment:
# variable "app_service_environment_id" {
#   description = "ID of the App Service Environment (if applicable)"
#   type        = string
#   default     = ""
# }