terraform {
  backend "azurerm" {
    resource_group_name  = "rg-taskflow-tfstate"
    storage_account_name = "sttaskflowtfstate123"
    container_name       = "tfstate"
    key                  = "taskflow-dev.tfstate"
  }
}