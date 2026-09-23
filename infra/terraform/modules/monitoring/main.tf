resource "azurerm_log_analytics_workspace" "taskflow" {
  name                = "law-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = "PerGB2018"
  retention_in_days = 30

  tags = {
    Project     = "TaskFlow"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_application_insights" "taskflow" {
  name                = "appi-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  application_type = "web"
  workspace_id     = azurerm_log_analytics_workspace.taskflow.id

  tags = {
    Project     = "TaskFlow"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}