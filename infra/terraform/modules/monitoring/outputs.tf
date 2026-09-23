output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.taskflow.id
}

output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.taskflow.name
}

output "application_insights_id" {
  value = azurerm_application_insights.taskflow.id
}

output "application_insights_name" {
  value = azurerm_application_insights.taskflow.name
}

output "application_insights_connection_string" {
  value     = azurerm_application_insights.taskflow.connection_string
  sensitive = true
}