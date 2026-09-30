output "acr_id" {
  value = azurerm_container_registry.taskflow.id
}

output "acr_name" {
  value = azurerm_container_registry.taskflow.name
}

output "login_server" {
  value = azurerm_container_registry.taskflow.login_server
}