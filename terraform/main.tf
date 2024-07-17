provider "azurerm" {
    features {
    }

    skip_provider_registration = true
}

resource "azurerm_resource_group" "rg-01" {
  name     = "dev-si-app-01"
  location = "South India"
}

resource "azurerm_resource_group" "rg-02" {
  name     = "int-si-app-01"
  location = "South India"
}