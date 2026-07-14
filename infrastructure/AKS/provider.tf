terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }

  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {
  }

  skip_provider_registration = false
}


