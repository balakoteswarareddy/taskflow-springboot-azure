output "server_name" {
  value = azurerm_postgresql_flexible_server.taskflow.name
}

output "server_id" {
  value = azurerm_postgresql_flexible_server.taskflow.id
}

output "server_fqdn" {
  value = azurerm_postgresql_flexible_server.taskflow.fqdn
}

output "administrator_login" {
  value = azurerm_postgresql_flexible_server.taskflow.administrator_login
}

output "database_name" {
  value = azurerm_postgresql_flexible_server_database.taskflow.name
}

