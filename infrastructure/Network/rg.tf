resource "azurerm_resource_group" "rg-01" {
  name     = local.resource_group_name
  location = "South India"
}

resource "azurerm_resource_group" "rg-02" {
  name     = lower("${ var.env }-si-app-02")
  location = "South India"
}