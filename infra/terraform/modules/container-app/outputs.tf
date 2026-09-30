output "container_app_id" {
  value = azurerm_container_app.taskflow.id
}

output "container_app_name" {
  value = azurerm_container_app.taskflow.name
}

output "container_app_url" {
  value = "https://${azurerm_container_app.taskflow.latest_revision_fqdn}"
}

output "container_app_fqdn" {
  value = azurerm_container_app.taskflow.latest_revision_fqdn
}

output "container_app_environment_id" {
  value = azurerm_container_app_environment.taskflow.id
}