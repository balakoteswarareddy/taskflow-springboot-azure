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

output "database_password_secret_id" {
  description = "Versionless Key Vault secret ID for the PostgreSQL password"
  value       = azurerm_key_vault_secret.db_password.versionless_id
}

output "jwt_secret_id" {
  description = "Versionless Key Vault secret ID for the JWT secret"
  value       = azurerm_key_vault_secret.jwt_secret.versionless_id
}