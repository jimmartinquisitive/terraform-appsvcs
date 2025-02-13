resource_group_name           = "my-resource-group"
location                      = "East US"
app_service_plan_name         = "my-app-service-plan"
app_service_plan_resource_group = "my-resource-group"   # Update if different from resource_group_name
app_service_plan_sku_tier     = "Isolated"
app_service_plan_sku_size     = "I1"
app_service_kind              = "app"
app_service_reserved          = "true"
maximum_elastic_worker_count  = "1"
app_service_name              = "my-app-service"
app_service_settings          = {
  "SETTING_KEY" = "value"
}