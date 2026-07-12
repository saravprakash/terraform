resource "azurerm_resource_group" "rg-01" {
  name     = local.resource_group_name
  location = "South India"
}

# resource "azurerm_resource_group" "rg-02" {
#   name     = "int-si-app-01"
#   location = "South India"
# }

# resource "azurerm_resource_group" "rg-03" {
#   name     = "uat-si-app-01"
#   location = "South India"
# }