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
  description = "The resource group name for the App Service Plan, if it already exists."
  type        = string
}

variable "app_service_plan_sku_tier" {
  description = "The SKU tier for the App Service Plan."
  type        = string
  default     = "Isolated"
}

variable "app_service_plan_sku_size" {
  description = "The SKU size for the App Service Plan."
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
  description = "Optional: configure scaling options."
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
