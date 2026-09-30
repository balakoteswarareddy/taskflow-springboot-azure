variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "container_app_environment_name" {
  type = string
}

variable "container_app_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "acr_login_server" {
  type = string
}

variable "managed_identity_id" {
  type = string
}

variable "key_vault_database_password_secret_id" {
  type = string
}

variable "key_vault_jwt_secret_id" {
  type = string
}

variable "database_url" {
  type = string
}

variable "database_username" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}