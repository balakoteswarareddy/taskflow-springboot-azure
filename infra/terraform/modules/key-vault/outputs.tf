output "key_vault_id" {
  value = azurerm_key_vault.taskflow.id
}

output "key_vault_name" {
  value = azurerm_key_vault.taskflow.name
}

output "key_vault_uri" {
  value = azurerm_key_vault.taskflow.vault_uri
}

output "managed_identity_id" {
  value = azurerm_user_assigned_identity.taskflow.id
}

output "managed_identity_client_id" {
  value = azurerm_user_assigned_identity.taskflow.client_id
}

output "managed_identity_principal_id" {
  value = azurerm_user_assigned_identity.taskflow.principal_id
}