output "resource_group_name" {
  value = azurerm_resource_group.taskflow.name
}

output "postgres_server_name" {
  value = module.postgres.server_name
}

output "postgres_fqdn" {
  value = module.postgres.fqdn
}

output "postgres_database_name" {
  value = module.postgres.database_name
}