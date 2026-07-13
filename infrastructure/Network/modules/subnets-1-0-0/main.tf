resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [each.value]

  service_endpoints = lookup(var.service_endpoints, each.key, [])

  dynamic "delegation" {
    for_each = length(var.subnet_delegations) > 0 && (var.subnet_delegations) != null ? var.subnet_delegations : {}
    content {
      name = delegation.key
      service_delegation {
        name = delegation.value["name"]
        actions = delegation.value["actions"]
      }
    }
  }
}

# Network Security Groups for each subnet
resource "azurerm_network_security_group" "nsg" {
  for_each = var.subnets

  name                = "${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Inbound rule: Allow port 443 from VNet to VNet
resource "azurerm_network_security_rule" "inbound_443" {
  for_each = var.subnets

  name                        = "${each.key}-inbound-443"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[each.key].name
}

# Outbound rule: Allow port 443 from VNet to VNet
resource "azurerm_network_security_rule" "outbound_443" {
  for_each = var.subnets

  name                        = "${each.key}-outbound-443"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[each.key].name
}

# Associate NSG with subnet
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each = var.subnets

  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}
