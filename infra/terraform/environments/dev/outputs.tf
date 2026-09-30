output "resource_group_name" {
  value = azurerm_resource_group.taskflow.name
}

output "postgres_server_name" {
  value = module.postgres.server_name
}

output "postgres_fqdn" {
  value = module.postgres.server_fqdn
}

output "postgres_administrator_login" {
  value = module.postgres.administrator_login
}

output "postgres_database_name" {
  value = module.postgres.database_name
}

output "log_analytics_workspace_id" {
  value = module.monitoring.log_analytics_workspace_id
}

output "acr_name" {
  value = module.acr.acr_name
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "acr_id" {
  value = module.acr.acr_id
}