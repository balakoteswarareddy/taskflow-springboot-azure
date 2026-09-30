resource "azurerm_container_registry" "taskflow" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku          = "Basic"
  admin_enabled = false

  tags = {
    Project     = "TaskFlow"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.taskflow.id
  role_definition_name = "AcrPull"
  principal_id         = var.managed_identity_principal_id
}