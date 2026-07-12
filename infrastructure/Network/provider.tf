provider "azurerm" {
    features {
    }

    skip_provider_registration = true
}

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "terraform-infra"
#     storage_account_name = "tfmtfstatefiles"                
#     container_name       = "tfstatefiles"            
#     key                  = "app01rmstatefile.tfstate"
#   }
# }

