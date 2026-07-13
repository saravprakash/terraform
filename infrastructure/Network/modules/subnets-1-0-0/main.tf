resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [each.value]

  service_endpoints = lookup(var.service_endpoints, each.key, [])

  dynamic "delegation" {
    for_each = length(var.subnet_delegations) > 0 && (var.subnet_delegations) != null ? [var.subnet_delegations] : {}
    content {
      name = subnet_delegation.value.service_delegation.name
      service_delegation {
        name    = subnet_delegation.value.service_delegation.name
        actions = subnet_delegation.value.service_delegation.actions
      }
    }
  }


}
