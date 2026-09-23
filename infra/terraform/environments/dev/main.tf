resource "azurerm_resource_group" "taskflow" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location

  tags = {
    Project     = "TaskFlow"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

module "postgres" {
  source = "../../modules/postgres"

  project_name            = var.project_name
  environment             = var.environment
  location                = var.location
  resource_group_name     = azurerm_resource_group.taskflow.name
  postgres_admin_username = var.postgres_admin_username
  postgres_admin_password = var.postgres_admin_password
  postgres_version        = var.postgres_version
  postgres_storage_mb     = var.postgres_storage_mb
  postgres_sku_name       = var.postgres_sku_name
}

module "key_vault" {
  source = "../../modules/key-vault"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.taskflow.name

  db_password = var.postgres_admin_password
  jwt_secret  = var.jwt_secret
}

module "monitoring" {
  source = "../../modules/monitoring"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.taskflow.name
}