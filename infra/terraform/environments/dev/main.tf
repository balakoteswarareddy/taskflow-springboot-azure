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

module "acr" {
  source = "../../modules/acr"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.taskflow.name

  acr_name = var.acr_name

  managed_identity_principal_id = module.key_vault.managed_identity_principal_id
}

module "monitoring" {
  source = "../../modules/monitoring"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.taskflow.name
}

module "container_app" {
  source = "../../modules/container-app"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.taskflow.name

  container_app_environment_name = "cae-taskflow-dev"
  container_app_name             = "ca-taskflow-dev"

  container_image  = "${module.acr.login_server}/taskapi:${var.container_image_tag}"
  acr_login_server = module.acr.login_server

  managed_identity_id = module.key_vault.managed_identity_id

  key_vault_database_password_secret_id = module.key_vault.database_password_secret_id
  key_vault_jwt_secret_id               = module.key_vault.jwt_secret_id

  database_url = "jdbc:postgresql://${module.postgres.server_fqdn}:5432/${module.postgres.database_name}?sslmode=require"

  database_username = module.postgres.administrator_login

  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id

  depends_on = [
    module.key_vault
  ]
}