# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-photo-portfolio-prod"
  location = "eastus2"
}

# Create a storage account
resource "azurerm_storage_account" "storage" {
  name                     = "stphotopmprodmb92"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "production"
    project     = "photo-portfolio"
  }
}

# Create storage containers
resource "azurerm_storage_container" "cnt_originals" {
  name                  = "originals"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "cnt_thumbnails" {
  name                  = "thumbnails"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"
}
