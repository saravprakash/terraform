resource "azurerm_resource_group" "rg-01" {
  name     = local.resource_group_name
  location = "South India"
}
