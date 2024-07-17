provider "azurerm" {
    features {
    }

    skip_provider_registration = true
}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-infra"
    storage_account_name = "rmtfstatefiles"                
    container_name       = "tfstatefiles"            
    key                  = "app01rmstatefile.tfstate"
  }
}

resource "azurerm_resource_group" "rg-01" {
  name     = "dev-si-app-01"
  location = "South India"
}

resource "azurerm_resource_group" "rg-02" {
  name     = "int-si-app-01"
  location = "South India"
}

resource "azurerm_resource_group" "rg-03" {
  name     = "uat-si-app-01"
  location = "South India"
}