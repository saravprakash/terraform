output "subnets" {
  description = "Map of subnet names to subnet resource objects"
  value       = azurerm_subnet.subnet
}

output "subnet_ids" {
  description = "Map of subnet names to subnet IDs"
  value = {
    for name, subnet in azurerm_subnet.subnet : name => subnet.id
  }
}

output "subnet_details" {
  description = "Detailed information about all created subnets"
  value = {
    for name, subnet in azurerm_subnet.subnet : name => {
      id              = subnet.id
      name            = subnet.name
      address_prefix  = subnet.address_prefixes[0]
      service_endpoints = subnet.service_endpoints
    }
  }
}

output "network_security_groups" {
  description = "Map of subnet names to NSG resource objects"
  value       = azurerm_network_security_group.nsg
}

output "nsg_ids" {
  description = "Map of subnet names to NSG IDs"
  value = {
    for name, nsg in azurerm_network_security_group.nsg : name => nsg.id
  }
}
