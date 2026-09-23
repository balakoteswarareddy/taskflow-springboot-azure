terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.6.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terraform_state" {
  name     = "rg-taskflow-tfstate"
  location = "Central India"

  tags = {
    Project   = "TaskFlow"
    ManagedBy = "Terraform"
    Purpose   = "Terraform State"
  }
}

resource "azurerm_storage_account" "terraform_state" {
  name                     = "sttaskflowtfstate123"
  resource_group_name      = azurerm_resource_group.terraform_state.name
  location                 = azurerm_resource_group.terraform_state.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  tags = {
    Project   = "TaskFlow"
    ManagedBy = "Terraform"
    Purpose   = "Terraform State"
  }
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.terraform_state.id
  container_access_type = "private"
}