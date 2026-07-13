variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "subnets" {
  description = "Map of subnet names to CIDR ranges"
  type        = map(string)
  # Example:
  # {
  #   "pe"   = "10.0.0.0/28"
  #   "swa"  = "10.0.0.16/28"
  #   "faob" = "10.0.0.32/28"
  #   "laob" = "10.0.0.48/28"
  # }
}

variable "service_endpoints" {
  description = "Map of subnet names to list of service endpoints"
  type        = map(list(string))
  default     = {}
  # Example:
  # {
  #   "pe"   = ["Microsoft.Storage", "Microsoft.KeyVault"]
  #   "swa"  = ["Microsoft.Web"]
  #   "faob" = ["Microsoft.Storage", "Microsoft.Sql"]
  #   "laob" = ["Microsoft.Storage", "Microsoft.ServiceBus"]
  # }
}


variable "subnet_delegations" {
  description = "Map of subnet names to subnet delegation configurations"
  type        = map(object({
      name    = string
      actions = list(string)
  }))
  default = {}
  # Example:
  # {
  #   "pe" = {
  #     service_delegation = {
  #       name    = "Microsoft.Web/serverFarms"
  #       actions = [
  #         "Microsoft.Network/virtualNetworks/subnets/join/action",
  #         "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
  #       ]
  #     }
  #   }
  # }
}
