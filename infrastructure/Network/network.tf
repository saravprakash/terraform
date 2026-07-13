resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  address_space       = ["10.0.0.0/25"]
  location            = azurerm_resource_group.rg-01.location
  resource_group_name = azurerm_resource_group.rg-01.name
}

module "subnets" {
  source = "./modules/subnets-1-0-0"

  virtual_network_name      = azurerm_virtual_network.vnet.name
  resource_group_name       = azurerm_resource_group.rg-01.name
  location                  = azurerm_resource_group.rg-01.location

  subnets                   = local.subnets_config
  service_endpoints         = local.service_endpoints_config
  subnet_delegations        = local.subnet_delegations
}
