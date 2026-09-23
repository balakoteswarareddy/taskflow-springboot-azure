resource "azurerm_user_assigned_identity" "taskflow" {
  name                = "id-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = {
    Project     = "TaskFlow"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_key_vault" "taskflow" {
  name                = "kv-${var.project_name}-${var.environment}-123"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id            = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  rbac_authorization_enabled = true

  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  tags = {
    Project     = "TaskFlow"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "managed_identity_secrets" {
  scope                = azurerm_key_vault.taskflow.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.taskflow.principal_id
}

resource "azurerm_role_assignment" "terraform_secrets" {
  scope                = azurerm_key_vault.taskflow.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_secret" "db_password" {
  name         = "database-password"
  value        = var.db_password
  key_vault_id = azurerm_key_vault.taskflow.id

  depends_on = [
    azurerm_role_assignment.terraform_secrets
  ]
}

resource "azurerm_key_vault_secret" "jwt_secret" {
  name         = "jwt-secret"
  value        = var.jwt_secret
  key_vault_id = azurerm_key_vault.taskflow.id

  depends_on = [
    azurerm_role_assignment.terraform_secrets
  ]
}