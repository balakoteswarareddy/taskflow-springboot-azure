resource "azurerm_postgresql_flexible_server" "taskflow" {
  name                   = "psql-${var.project_name}-${var.environment}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.postgres_version
  administrator_login    = var.postgres_admin_username
  administrator_password = var.postgres_admin_password

  storage_mb   = var.postgres_storage_mb
  sku_name     = var.postgres_sku_name
  zone         = "1"

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  tags = {
    Project     = "TaskFlow"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_postgresql_flexible_server_database" "taskflow" {
  name      = "taskflow"
  server_id = azurerm_postgresql_flexible_server.taskflow.id

  charset   = "UTF8"
  collation = "en_US.utf8"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}