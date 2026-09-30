resource "azurerm_container_app_environment" "taskflow" {
  name                = var.container_app_environment_name
  location            = var.location
  resource_group_name = var.resource_group_name

  logs_destination          = "log-analytics"
  log_analytics_workspace_id = var.log_analytics_workspace_id

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_container_app" "taskflow" {
  name                         = var.container_app_name
  container_app_environment_id = azurerm_container_app_environment.taskflow.id
  resource_group_name          = var.resource_group_name

  revision_mode = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = [var.managed_identity_id]
  }

  registry {
    server   = var.acr_login_server
    identity = var.managed_identity_id
  }

  secret {
    name                = "database-password"
    identity            = var.managed_identity_id
    key_vault_secret_id = var.key_vault_database_password_secret_id
  }

  secret {
    name                = "jwt-secret"
    identity            = var.managed_identity_id
    key_vault_secret_id = var.key_vault_jwt_secret_id
  }

  template {
    min_replicas = 1
    max_replicas = 2

    container {
      name   = "taskapi"
      image  = var.container_image
      cpu    = 0.5
      memory = "1Gi"

      env {
        name  = "DB_URL"
        value = var.database_url
      }

      env {
        name  = "DB_USERNAME"
        value = var.database_username
      }

      env {
        name        = "DB_PASSWORD"
        secret_name = "database-password"
      }

      env {
        name        = "JWT_SECRET"
        secret_name = "jwt-secret"
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = 8080
    transport        = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}