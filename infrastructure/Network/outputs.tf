output "virtual_network_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "virtual_network_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnets" {
  description = "Map of all created subnets with their details"
  value       = module.subnets.subnet_details
}

output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value       = module.subnets.subnet_ids
}
