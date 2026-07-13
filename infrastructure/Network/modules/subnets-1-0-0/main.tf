resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [each.value]

  subnet_delegation = var.subnet_delegations

  service_endpoints = lookup(var.service_endpoints, each.key, null)

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
