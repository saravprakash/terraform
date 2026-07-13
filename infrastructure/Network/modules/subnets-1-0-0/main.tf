resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [each.value]

  service_endpoints = lookup(var.service_endpoints, each.key, [])

  dynamic "subnet_delegation" {
    for_each = lookup(var.subnet_delegations, each.key, null) != null ? [var.subnet_delegations[each.key]] : []
    content {
      name = subnet_delegation.value.service_delegation.name
      service_delegation {
        name    = subnet_delegation.value.service_delegation.name
        actions = subnet_delegation.value.service_delegation.actions
      }
    }
  }

  enforce_private_link_endpoint_network_policies = (
    lookup(var.additional_properties, each.key, null) != null
    ? var.additional_properties[each.key].enforce_private_link_endpoint_network_policies
    : false
  )

  enforce_private_link_service_network_policies = (
    lookup(var.additional_properties, each.key, null) != null
    ? var.additional_properties[each.key].enforce_private_link_service_network_policies
    : false
  )
}
